#include "udpserver.h"

UDPServer::UDPServer(QObject *parent)
    : QObject(parent),
    m_udpSocket(new QUdpSocket(this)),
    m_receiveSocket(new QUdpSocket(this)),
    m_timer(new QTimer(parent)),
    m_packetsSent(0),
    m_threadPool(new QThreadPool(this)) // 创建线程池
{
    m_frequency = 25;
    m_totalPackets = 25;
    m_threadNum = 25;
    m_sentPackets = 0;
    m_threadPool->setMaxThreadCount(m_threadNum);
    //m_udpSocket = new QUdpSocket;
    //m_threadPool = new QThreadPool;
    //m_timer = new QTimer(parent);
    connect(m_timer, &QTimer::timeout, this, &UDPServer::sendPacket);

    connect(m_udpSocket, &QUdpSocket::readyRead, this, &UDPServer::receivePacket);
    // 设置线程池的最大线程数（默认25）

    // 初始化 SQLite 数据库连接
    m_db_rec = QSqlDatabase::addDatabase("QSQLITE");
    m_db_rec.setDatabaseName("udp_data_rec.db");
    m_db_send = QSqlDatabase::addDatabase("QSQLITE");
    m_db_send.setDatabaseName("udp_data_send.db");
    if (!m_db_rec.open()) {
        qDebug() << "Cannot open database:" << m_db_rec.lastError();
    } else {
        qDebug() << "Database opened successfully.";

        // 创建表格
        QSqlQuery query;
        QString createTableQuery = "CREATE TABLE IF NOT EXISTS udp_data ("
                                   "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                                   "timestamp TEXT,"
                                   "sender_ip TEXT,"
                                   "sender_port INTEGER,"
                                   "data TEXT)";
        if (!query.exec(createTableQuery)) {
            qDebug() << "Failed to create table:" << query.lastError();
        }
    }

    if (!m_db_send.open()) {
        qDebug() << "Cannot open database:" << m_db_send.lastError();
    } else {
        qDebug() << "Database opened successfully.";

        // 创建表格
        QSqlQuery query;
        QString createTableQuery = "CREATE TABLE IF NOT EXISTS udp_data ("
                                   "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                                   "timestamp TEXT,"
                                   "sender_ip TEXT,"
                                   "sender_port INTEGER,"
                                   "data TEXT)";
        if (!query.exec(createTableQuery)) {
            qDebug() << "Failed to create table:" << query.lastError();
        }
    }

}

UDPServer::~UDPServer()
{
    // 停止定时器
    if (m_timer) {
        m_timer->stop();
        delete m_timer;
        m_timer = nullptr;
    }

    // 释放 UDP 套接字
    if (m_udpSocket) {
        m_udpSocket->close();
        delete m_udpSocket;
        m_udpSocket = nullptr;
    }

    // 释放接收 UDP 套接字
    if (m_receiveSocket) {
        m_receiveSocket->close();
        delete m_receiveSocket;
        m_receiveSocket = nullptr;
    }

    // 等待线程池中的所有任务完成
    if (m_threadPool) {
        m_threadPool->waitForDone();  // 确保所有任务完成
        delete m_threadPool;
        m_threadPool = nullptr;
    }
    delete m_timer;
    delete m_udpSocket;
}



void UDPServer::setDestIP(QString destIP)
{
    m_destIP  = destIP;
}

void UDPServer::setDestPort(QString destPort)
{
    m_destPort = destPort;
}

void UDPServer::setThreadNum(int num)
{
    m_threadNum = num;
    m_threadPool->setMaxThreadCount(m_threadNum);
}

void UDPServer::setFieldDefinitions(QList<FieldDefinition> fieldDefinitions)
{
    m_fieldDefinitions = fieldDefinitions;
}

QString generateRandomIPAddress() {
    QRandomGenerator *generator = QRandomGenerator::global();

    // 生成四个 0 到 255 之间的随机整数
    int octet1 = generator->bounded(256);
    int octet2 = generator->bounded(256);
    int octet3 = generator->bounded(256);
    int octet4 = generator->bounded(256);

    // 格式化为标准的 IP 地址形式
    QString ipAddress = QString("%1.%2.%3.%4")
                            .arg(octet1)
                            .arg(octet2)
                            .arg(octet3)
                            .arg(octet4);

    return ipAddress;
}

QByteArray UDPServer::generateRandomData(const FieldDefinition &field)
{
    QByteArray data;
    if (field.datatype == "DEC") {
        // 生成无符号十进制
        quint32 value = QRandomGenerator::global()->bounded(field.minimum.toUInt(), field.maximum.toUInt() + 1);
        data.append("DEC:"+QString::number(value).rightJustified(field.length / 8, '0').toUtf8());
    } else if (field.datatype == "INT") {
        // 生成有符号十进制
        qint32 value = QRandomGenerator::global()->bounded(field.minimum.toInt(), field.maximum.toInt() + 1);
        data.append("INT:"+QString::number(value).rightJustified(field.length / 8, '0').toUtf8());

    } else if (field.datatype == "BIN") {
        data.append("BIN:");
        // 生成二进制字符串
        for (int i = 0; i < field.length; ++i) {
            data.append(QRandomGenerator::global()->bounded(2) ? '1' : '0');
        }

    } else if (field.datatype == "OCT") {
        // 生成八进制字符串
        quint32 value = QRandomGenerator::global()->bounded(field.minimum.toUInt(), field.maximum.toUInt() + 1);
        data.append("OCT:"+QString::number(value, 8).rightJustified(field.length / 8, '0').toUtf8());

    } else if (field.datatype == "HEX") {
        // 生成十六进制字符串
        quint32 value = QRandomGenerator::global()->bounded(field.minimum.toUInt(), field.maximum.toUInt() + 1);
        data.append("HEX:"+QString::number(value, 16).rightJustified(field.length / 8, '0').toUtf8());

    } else if (field.datatype == "FLT") {
        // 生成浮点型数
        float value = field.minimum.toFloat() + QRandomGenerator::global()->generateDouble() * (field.maximum.toFloat() - field.minimum.toFloat());
        data.append("FLT:"+QByteArray::number(value, 'f', field.precision));

    } else if (field.datatype == "DBL") {
        // 生成双精度浮点型数
        double value = field.minimum.toDouble() + QRandomGenerator::global()->generateDouble() * (field.maximum.toDouble() - field.minimum.toDouble());
        data.append("DBL:"+QByteArray::number(value, 'f', field.precision));
    } else if (field.datatype == "STRING") {
        // 生成字符串
        data.append("STRING:");
        for (int i = 0; i < field.length / 8; ++i) {
            char c = static_cast<char>(QRandomGenerator::global()->bounded(32, 127));
            data.append(c);
        }

    } else if (field.datatype == "FLAG") {
        // 生成标志位
        data.append("FLAG:");
        char flag = static_cast<char>(QRandomGenerator::global()->bounded(256));
        data.append(flag);
    } else if (field.datatype == "IP") {
        data.append("IP:");
        // 生成随机 IP 地址
        QString ipAddress = generateRandomIPAddress();
        data.append(ipAddress.toUtf8());
    }
    return data;
}



QList<QByteArray> UDPServer::generateMessageData(QList<FieldDefinition> fieldDefinitions)
{
    QByteArray messageData;
    QList<QByteArray> msgData;
    for (const auto& field : fieldDefinitions) {
        msgData.append(generateRandomData(field));
    }
    return msgData;
}



void UDPServer::startSending()
{
    if (!m_isSending) {
        m_isSending = true;
        int interval = 1000/m_frequency; // 计算发送间隔（毫秒）
        m_timer->start(interval);
        //qDebug() <<"m_frequency" <<m_frequency ;
        //qDebug() <<"interval:" <<interval ;
    }
}

void UDPServer::stopSending()
{
    if (m_isSending) {
        m_isSending = false;
        m_timer->stop();
        //emit sendingStopped();
    }
}

bool UDPServer::bind(QString ip, QString port)
{
    return m_udpSocket->bind(QHostAddress(ip), port.toUInt());
}

void UDPServer::sendPacket()
{
    static int dataIndex = 0;
    if(dataIndex == m_data.count())dataIndex = 0;
    m_data = generateMessageData(m_fieldDefinitions);
    QByteArray datagram;

    if (!m_isSending) {
        return;
    }

    // UDP报文后续修改
    datagram = m_data.at(dataIndex); // 报文
    dataIndex++;
    // 使用线程池发送数据
    SendTask *task = new SendTask(m_udpSocket, datagram, m_destIP, m_destPort.toUInt());
    m_threadPool->start(task);
    //  单线程发送数据
    //m_udpSocket->writeDatagram(datagram, QHostAddress(m_destIP), m_destPort.toUInt());
    qDebug() << "ip:" << m_destIP << "port:" << m_destPort.toUInt()  << "线程数:" << m_threadNum << "内容:" <<datagram <<"编号" << m_sentPackets;

    m_sentPackets++;
    qDebug() << "m_sentPackets" << m_sentPackets;
    if (m_totalPackets > 0 && m_sentPackets >= m_totalPackets) {
        stopSending();
        emit sendFinished();
        qDebug() << "stopped: sent:"<< m_sentPackets <<"total:"<<m_totalPackets;
        m_sentPackets = 0;
    }
    QtConcurrent::run(&UDPServer::saveDataToDatabase, m_db_send, m_destIP,  m_destPort.toUInt(), datagram);
    //emit packetSent();

}

void UDPServer::receivePacket()
{
    while (m_udpSocket->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(m_udpSocket->pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        m_udpSocket->readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);
        qDebug() << "Received datagram from" << sender.toString() << ":" << senderPort << ":" << datagram;
        // 处理接收到的报文
        // 使用线程池处理接收到的数据
        ReceiveTask *task = new ReceiveTask(m_udpSocket, sender, senderPort, datagram);
        m_threadPool->start(task);

        // 将数据库写入操作放入线程池中执行
        QtConcurrent::run(&UDPServer::saveDataToDatabase, m_db_rec, sender.toString(), senderPort, datagram);
    }
}

void UDPServer::saveDataToDatabase(QSqlDatabase db, const QString &senderIp, quint16 senderPort, const QByteArray &data)
{
    if (!db.isOpen()) {
        qDebug() << "Database is not open!";
        return;
    }

    //克隆一个新的数据库连接
    QSqlDatabase threadDb = QSqlDatabase::cloneDatabase(db, QString::number((quintptr)QThread::currentThreadId()));
    threadDb.open();

    QSqlQuery query(threadDb);
    query.prepare("INSERT INTO udp_data (timestamp, sender_ip, sender_port, data) "
                  "VALUES (:timestamp, :sender_ip, :sender_port, :data)");

    query.bindValue(":timestamp", QDateTime::currentDateTime().toString(Qt::ISODate));
    query.bindValue(":sender_ip", senderIp);
    query.bindValue(":sender_port", senderPort);
    query.bindValue(":data", QString(data));

    if (!query.exec()) {
        qDebug() << "Failed to insert data into database:" << query.lastError();
    } else {
        qDebug() << "Data inserted successfully.";
    }

    threadDb.close();
}
QVariantList UDPServer::searchInSendDb(const QString &searchTerm) {
    QVariantList results;
    QSqlQuery query(m_db_send);

    // 使用 OR 连接多个列的搜索条件
    query.prepare("SELECT * FROM udp_data WHERE "
                  "id LIKE :searchTerm OR "
                  "timestamp LIKE :searchTerm OR "
                  "sender_ip LIKE :searchTerm OR "
                  "sender_port LIKE :searchTerm OR "
                  "data LIKE :searchTerm");

    query.bindValue(":searchTerm", "%" + searchTerm + "%");

    if (query.exec()) {
        while (query.next()) {
            QVariantMap row;
            row["id"] = query.value("id");
            row["timestamp"] = query.value("timestamp");
            row["sender_ip"] = query.value("sender_ip");
            row["sender_port"] = query.value("sender_port");
            row["data"] = query.value("data");
            results.append(row);
        }
    } else {
        qDebug() << "Search query failed:" << query.lastError();
    }
    return results;
}


QVariantList UDPServer::searchInRecDb(const QString &searchTerm) {
    QVariantList results;
    QSqlQuery query(m_db_rec);

    query.prepare("SELECT * FROM udp_data WHERE "
                  "id LIKE :searchTerm OR "
                  "timestamp LIKE :searchTerm OR "
                  "sender_ip LIKE :searchTerm OR "
                  "sender_port LIKE :searchTerm OR "
                  "data LIKE :searchTerm");

    query.bindValue(":searchTerm", "%" + searchTerm + "%");

    if (query.exec()) {
        while (query.next()) {
            QVariantMap row;
            row["id"] = query.value("id");
            row["timestamp"] = query.value("timestamp");
            row["sender_ip"] = query.value("sender_ip");
            row["sender_port"] = query.value("sender_port");
            row["data"] = query.value("data");
            results.append(row);
        }
    } else {
        qDebug() << "Search query failed:" << query.lastError();
    }
    return results;
}
