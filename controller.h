#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QQuickItem>
#include <xmlprotocolparser.h>
#include <QString>
#include <QList>
#include <QHostAddress>
#include <QRegularExpression>
#include <udpserver.h>
#include <QHostAddress>
#include <QNetworkInterface>
#include <QList>
#include <udpsendtask.h>
#include <udpreceivetask.h>
#include <QVariantList>
#include <sendtablemodel.h>

class controller : public QQuickItem
{
    Q_OBJECT
    QML_ELEMENT
public:
    controller();
    Q_INVOKABLE bool selectXMLFile(const QString &fileUrl);
    Q_INVOKABLE QString getProtocolConfigAsString(); // 获取配置信息
    Q_INVOKABLE QString getSourceIP();
    Q_INVOKABLE QString getSourcePort();
    Q_INVOKABLE QString getDestinationIP();
    Q_INVOKABLE QString getDestinationPort();
    Q_INVOKABLE void setDestinationIP(QString DestIP);
    Q_INVOKABLE void setDestinationPort(QString DestPort);
    Q_INVOKABLE bool checkIPString(QString ipStr);//判断是否为IP
    Q_INVOKABLE bool checkPortString(QString portStr);

    Q_INVOKABLE void setFrequence(QString Freq);
    Q_INVOKABLE void setNumber(QString Num);
    Q_INVOKABLE void setThreadNum(QString ThreadNum);
    Q_INVOKABLE QString getMyIP();
    //Q_INVOKABLE bool initializeServer(int freq,int num);
    //Q_INVOKABLE void startSending();
    //Q_INVOKABLE void stopSending();
    ProtocolConfig refreshProtocolConfig(); // 获取协议配置信息
    QList<FieldDefinition> refreshFieldDefinitions();
    //QList<QByteArray> generateMessageData();
    //QByteArray generateRandomData(const FieldDefinition &field);
    Q_INVOKABLE QVariantList searchInSendDb(const QString &searchTerm);
    Q_INVOKABLE QVariantList searchInRecDb(const QString &searchTerm);
signals:
    void xmlFilePathChanged(); // 路径改变信号
    void protocolConfigChanged(); // 协议配置改变信号
    void sendingStarted();
    void sendingStopped();
    void sendingStateChanged();
private:
    XMLProtocolParser m_xmlParser;
    ProtocolConfig m_protocolConfig; // 存储协议配置信息
    QList<FieldDefinition> m_fieldDefinitions;  // 字段定义列表
    UDPServer m_udpServer;
    bool m_isSending;
    SendTableModel sendTableModel;
public slots:
    void startSending();
    void stopSending();
};

#endif // CONTROLLER_H
