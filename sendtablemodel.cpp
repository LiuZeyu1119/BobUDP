#include "sendtablemodel.h"

SendTableModel::SendTableModel(QObject *parent)
    : QAbstractListModel(parent) {}

int SendTableModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_data.size();
}

QVariant SendTableModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_data.size())
        return QVariant();

    const QVariantMap &rowData = m_data.at(index.row());
    switch (role) {
    case IdRole:
        return rowData["id"];
    case TimestampRole:
        return rowData["timestamp"];
    case SenderIpRole:
        return rowData["sender_ip"];
    case SenderPortRole:
        return rowData["sender_port"];
    case DataRole:
        return rowData["data"];
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> SendTableModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[TimestampRole] = "timestamp";
    roles[SenderIpRole] = "sender_ip";
    roles[SenderPortRole] = "sender_port";
    roles[DataRole] = "data";
    return roles;
}

void SendTableModel::addData(const QVariantMap &data) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data.append(data);
    endInsertRows();
}

void SendTableModel::clearData() {
    beginResetModel();
    m_data.clear();
    endResetModel();
}
