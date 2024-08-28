#ifndef UDPRECEIVETASK_H
#define UDPRECEIVETASK_H
#include <QRunnable>
#include <QUdpSocket>
#include <udpserver.h>

class ReceiveTask : public QRunnable
{
public:
    ReceiveTask(QUdpSocket *socket, const QHostAddress &sender, quint16 senderPort, const QByteArray &data)
        : m_socket(socket), m_sender(sender), m_senderPort(senderPort), m_data(data) {}

    void run() override {
        // 在这里处理接收到的报文
        qDebug() << "Processing received datagram from" << m_sender.toString() << ":" << m_senderPort << "Data:" << m_data;
    }

private:
    QUdpSocket *m_socket;
    QHostAddress m_sender;
    quint16 m_senderPort;
    QByteArray m_data;
};

#endif // UDPRECEIVETASK_H
