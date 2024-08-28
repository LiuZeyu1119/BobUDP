#include "controller.h"
#include <QDebug>
controller::controller() {
    connect(&m_udpServer,&UDPServer::sendFinished,this,&controller::stopSending);
}

bool controller::selectXMLFile(const QString &fileUrl)
{
    QString localFilePath = QUrl(fileUrl).toLocalFile();
    qDebug() << "Selected XML file:" << localFilePath;
    if(m_xmlParser.parseProtocol(localFilePath))
    {
        refreshProtocolConfig();
        refreshFieldDefinitions();
        return true;
    }
    return false;

}

ProtocolConfig controller::refreshProtocolConfig() {
    m_protocolConfig = m_xmlParser.getProtocolConfig();
    return m_protocolConfig;
}

QList<FieldDefinition> controller::refreshFieldDefinitions()
{
    m_fieldDefinitions = m_xmlParser.getFieldDefinitions();
    return m_fieldDefinitions;
}



QString controller::getProtocolConfigAsString() {
    QString configStr;
    configStr += "Source IP: " + m_protocolConfig.sourceIP + "\n";
    configStr += "Destination IP: " + m_protocolConfig.destIP + "\n";
    configStr += "Source Port: " + m_protocolConfig.sourcePort + "\n";
    configStr += "Destination Port: " + m_protocolConfig.destPort + "\n";
    configStr += "Protocol Header: " + m_protocolConfig.protoHead + "\n";
    configStr += "Type: " + m_protocolConfig.nType + "\n";
    configStr += "System: " + m_protocolConfig.system ; //+ "\n";
    qDebug() << "configStr:" << configStr;
    return configStr;
}

QString controller::getSourceIP()
{
    return m_protocolConfig.sourceIP;
}

QString controller::getSourcePort()
{
    return m_protocolConfig.sourcePort;
}

QString controller::getDestinationIP()
{
    return m_protocolConfig.destIP;
}

QString controller::getDestinationPort()
{
    return m_protocolConfig.destPort;
}

void controller::setDestinationIP(QString DestIP)
{
    m_protocolConfig.destIP = DestIP;
    m_udpServer.setDestIP(m_protocolConfig.destIP);
}

void controller::setDestinationPort(QString DestPort)
{
    m_protocolConfig.destPort = DestPort;
    m_udpServer.setDestPort(m_protocolConfig.destPort);
}

bool controller::checkIPString(QString ipStr)
{
    QHostAddress Address;//借助QHostAddress判断输入的内容的格式是不是IP
    return Address.setAddress(ipStr.trimmed()); //timmed是去掉空格
}

bool controller::checkPortString(QString portStr)
{
    return (portStr.toInt() > 0 && portStr.toInt() <= 65536);
}

void controller::setFrequence(QString freq)
{
    m_udpServer.m_frequency = freq.toInt();
}

void controller::setNumber(QString num)
{
    m_udpServer.m_totalPackets = num.toInt();
}

void controller::setThreadNum(QString threadNum)
{
    m_udpServer.setThreadNum(threadNum.toInt());
}

QString controller::getMyIP()
{
    static int selectNum = -1;
    int curNum = 0;
    int countIPV4 = 0;
    QList<QHostAddress> list =QNetworkInterface::allAddresses();
    selectNum++;
    foreach (QHostAddress address, list)
    {
        if(address.protocol() == QAbstractSocket::IPv4Protocol)countIPV4++;
    }
    foreach (QHostAddress address, list)
    {
        if(address.protocol() == QAbstractSocket::IPv4Protocol){
            qDebug() << address;
            if(curNum != selectNum) {
                curNum ++;
                continue;
            }else{
                return address.toString();
            }
        }
        if(selectNum == countIPV4){
            countIPV4 = 0;
            selectNum =-1;
        }
    }
    return 0;

}



void controller::startSending()
{
    if (!m_isSending) {
        m_udpServer.bind("0.0.0.0","2000");
        qDebug() << "绑定";
        //m_udpServer.initializeServer(m_protocolConfig.destIP, m_protocolConfig.destPort, 1,  0);
        //m_udpServer.importData(generateMessageData());
        m_udpServer.setFieldDefinitions(m_fieldDefinitions);
        m_udpServer.startSending();
        m_isSending = true;
        emit sendingStarted();
        emit sendingStateChanged();
    }
}

void controller::stopSending()
{
    if (m_isSending) {
        m_udpServer.stopSending();
        m_isSending = false;
        emit sendingStopped();
        emit sendingStateChanged();
    }
}


// QVariantList controller::searchInSendDb(const QString &searchTerm) {
//     return m_udpServer.searchInSendDb(searchTerm);
// }

QVariantList controller::searchInRecDb(const QString &searchTerm) {
    return m_udpServer.searchInRecDb(searchTerm);
}

QVariantList controller::searchInSendDb(const QString &searchTerm) {
    QVariantList results = m_udpServer.searchInSendDb(searchTerm);
    sendTableModel.clearData(); // 清空旧数据

    for (const QVariant &result : results) {
        sendTableModel.addData(result.toMap()); // 添加新数据
    }

    return results;
}

