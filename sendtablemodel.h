#ifndef SENDTABLEMODEL_H
#define SENDTABLEMODEL_H

#include <QAbstractListModel>
#include <QVariant>

class SendTableModel : public QAbstractListModel {
    Q_OBJECT
public:
    enum RoleNames {
        IdRole = Qt::UserRole + 1,
        TimestampRole,
        SenderIpRole,
        SenderPortRole,
        DataRole
    };

    explicit SendTableModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addData(const QVariantMap &data);
    Q_INVOKABLE void clearData();


private:
    QList<QVariantMap> m_data;
};

#endif // SENDTABLEMODEL_H
