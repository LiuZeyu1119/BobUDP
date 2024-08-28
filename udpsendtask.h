#ifndef UDPSENDTASK_H
#define UDPSENDTASK_H
#include <QRunnable>
#include <QUdpSocket>
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

class SendTask : public QRunnable
{
public:
    SendTask(QUdpSocket *socket, const QByteArray &data, const QString &destIP, quint16 destPort)
        : m_socket(socket), m_data(data), m_destIP(destIP), m_destPort(destPort) {}

    void run() override {
        m_socket->writeDatagram(m_data, QHostAddress(m_destIP), m_destPort);
        qDebug() << "Sent datagram to" << m_destIP << ":" << m_destPort << "Data:" << m_data;
    }


private:
    QUdpSocket *m_socket;
    QByteArray m_data;
    QString m_destIP;
    quint16 m_destPort;
};

#endif // UDPSENDTASK_H
