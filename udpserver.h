#ifndef UDPSERVER_H
#define UDPSERVER_H

#include <QObject>
#include <QFile>
#include <QFileDialog>
#include <QMessageBox>
#include <QWidget>
#include <QString>
#include <QUdpSocket>
#include <QTimer>
#include <xmlprotocolparser.h>
#include <QRandomGenerator>
#include <QThreadPool>
#include <udpsendtask.h>
#include <udpreceivetask.h>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include <QVariant>
#include <QtConcurrent/QtConcurrent>
#include <QVariantList>
class UDPServer : public QObject
{
    Q_OBJECT
public:
    explicit UDPServer(QObject *parent = nullptr);
    ~UDPServer();
    void startSending();
    void stopSending();
    bool bind(QString ip, QString port);
    void setDestIP(QString destIP);
    void setDestPort(QString destPort);
    void setThreadNum(int num);
    void setFieldDefinitions(QList<FieldDefinition> fieldDefinitions);
    QByteArray generateRandomData(const FieldDefinition &field);
    QList<QByteArray> generateMessageData(QList<FieldDefinition> fieldDefinitions);
    static void saveDataToDatabase(QSqlDatabase db, const QString &senderIp, quint16 senderPort, const QByteArray &data);
    QVariantList searchInSendDb(const QString &searchTerm);
    QVariantList searchInRecDb(const QString &searchTerm);
public:
    int m_frequency;
    int m_totalPackets;
    int m_threadNum;
    QList<QByteArray> m_data;
private:
    QString m_destIP;
    QString m_destPort;
    QUdpSocket *m_udpSocket;
    QUdpSocket *m_receiveSocket;
    QDateTime m_startTime;
    QDateTime m_endTime;

    QThreadPool *m_threadPool;

    int m_packetsSent;
    int m_timerId;
    QTimer *m_timer;
    QThread *m_thread;

    int m_sentPackets;
    bool m_isSending;
    //QMutex m_mutex;
    QSqlDatabase m_db_rec;
    QSqlDatabase m_db_send;
    QList<FieldDefinition> m_fieldDefinitions;  // 字段定义列表
signals:
    void errorOccurred(const QString &error);
    void packetSent();
    //void sendingStopped();
    void sendFinished();

private slots:
    void sendPacket();
    void receivePacket();

};

#endif // UDPSERVER_H
