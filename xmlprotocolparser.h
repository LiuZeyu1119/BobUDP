#ifndef XMLPROTOCOLPARSER_H
#define XMLPROTOCOLPARSER_H
#include <QString>
#include <QFile>
#include <QXmlStreamReader>
#include <QDebug>

// 存储字段定义
struct FieldDefinition {
    QString fieldName;    // 字段名称
    bool isSelected;      // 是否为解析存储式关注的字段
    QString datatype;     // 数据类型
    QString data;         // 标识字段信息
    int bitIndex;         // 开始位置
    int length;           // 字段长度
    int loopEnd;          // 结束位置
    QString comment;      // 字段说明
    QString minimum;      // 最小值
    QString maximum;      // 最大值
    int precision;        // 精度
    bool isKey;           // 是否为标识字段
};

// 存储协议配置信息
struct ProtocolConfig {
    QString sourceIP;    // 源IP
    QString destIP;      // 目的IP
    QString sourcePort;  // 源端口
    QString destPort;    // 目的端口
    QString protoHead;   // 报文头
    QString nType;       // 报文类型
    QString system;      // 系统
};


class XMLProtocolParser
{
public:
    XMLProtocolParser();

    bool parseProtocol(const QString &filePath);
    // 获取字段定义列表
    QList<FieldDefinition> getFieldDefinitions() const;//  const防止成员变量更改
    // 获取协议配置信息
    ProtocolConfig getProtocolConfig();
private:
    QList<FieldDefinition> fieldDefinitions;  // 字段定义列表
    ProtocolConfig protocolConfig;  // 协议配置信息
};

#endif // XMLPROTOCOLPARSER_H
