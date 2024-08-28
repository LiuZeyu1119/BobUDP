#include "xmlprotocolparser.h"

XMLProtocolParser::XMLProtocolParser() {}

bool XMLProtocolParser::parseProtocol(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Cannot open file for reading:" << filePath;
        return false;
    }else{
        qDebug() << "Open file for reading:" << filePath;
    }
    //  XML读取器初始化
    QXmlStreamReader xmlReader(&file);

    qDebug() << "init xml Reader from" << filePath;
    // 循环读取XML文件内容
    while (!xmlReader.atEnd() && !xmlReader.hasError()) {
        QXmlStreamReader::TokenType token = xmlReader.readNext();
        // 跳过文档开始令牌
        if (token == QXmlStreamReader::StartDocument) {
            qDebug() << "跳过开始令牌" ;
            continue;
        }
        if (token == QXmlStreamReader::StartElement) {
            // 解析XML元素
            //xmlReader.name()返回的是QStringView，而不是QString将const char*类型转换为QStringView。
            if (xmlReader.name() == QStringView(u"field")) {
                qDebug() << "进入field" ;
                FieldDefinition fieldDef;
                while (!(xmlReader.tokenType() == QXmlStreamReader::EndElement && xmlReader.name() == QStringView(u"field"))) {
                    if (xmlReader.tokenType() == QXmlStreamReader::StartElement) {
                        if (xmlReader.name() == QStringView(u"fieldName")) {
                            fieldDef.fieldName = xmlReader.readElementText();  // 读取字段名称
                        } else if (xmlReader.name() == QStringView(u"isSelected")) {
                            fieldDef.isSelected = (xmlReader.readElementText().toLower() == "true");  // 读取是否关注字段
                        } else if (xmlReader.name() == QStringView(u"datatype")) {
                            fieldDef.datatype = xmlReader.readElementText();  // 读取数据类型
                        } else if (xmlReader.name() == QStringView(u"data")) {
                            fieldDef.data = xmlReader.readElementText();  // 读取字段数据
                        } else if (xmlReader.name() == QStringView(u"bitIndex")) {
                            fieldDef.bitIndex = xmlReader.readElementText().toInt();  // 读取开始位置
                        } else if (xmlReader.name() == QStringView(u"length")) {
                            fieldDef.length = xmlReader.readElementText().toInt();  // 读取字段长度
                        } else if (xmlReader.name() == QStringView(u"loopEnd")) {
                            fieldDef.loopEnd = xmlReader.readElementText().toInt();  // 读取结束位置
                        } else if (xmlReader.name() == QStringView(u"comment")) {
                            fieldDef.comment = xmlReader.readElementText();  // 读取字段说明
                        } else if (xmlReader.name() == QStringView(u"minimum")) {
                            fieldDef.minimum = xmlReader.readElementText();  // 读取最小值
                        } else if (xmlReader.name() == QStringView(u"maximum")) {
                            fieldDef.maximum = xmlReader.readElementText();  // 读取最大值
                        } else if (xmlReader.name() == QStringView(u"precision")) {
                            fieldDef.precision = xmlReader.readElementText().toInt();  // 读取精度
                        } else if (xmlReader.name() == QStringView(u"isKey")) {
                            fieldDef.isKey = (xmlReader.readElementText().toLower() == "true");  // 读取是否为标识字段
                        }
                    }
                    xmlReader.readNext();
                }
                fieldDefinitions.append(fieldDef);


            }else if (xmlReader.name() == QStringView(u"sourceIP")) {
                protocolConfig.sourceIP = xmlReader.readElementText();  // 读取源IP
                qDebug() << "protocolConfig.sourceIP: "<<protocolConfig.sourceIP ;

            } else if (xmlReader.name() == QStringView(u"destIP")) {
                protocolConfig.destIP = xmlReader.readElementText();  // 读取目的IP
            } else if (xmlReader.name() == QStringView(u"sourcePort")) {
                protocolConfig.sourcePort = xmlReader.readElementText();  // 读取源端口
            } else if (xmlReader.name() == QStringView(u"destPort")) {
                protocolConfig.destPort = xmlReader.readElementText();  // 读取目的端口
            } else if (xmlReader.name() == QStringView(u"protoHead")) {
                protocolConfig.protoHead = xmlReader.readElementText();  // 读取报文头
            } else if (xmlReader.name() == QStringView(u"nType")) {
                protocolConfig.nType = xmlReader.readElementText();  // 读取报文类型
            } else if (xmlReader.name() == QStringView(u"system")) {
                protocolConfig.system = xmlReader.readElementText();  // 读取系统
            }
        }
    }

    if (xmlReader.hasError()) {
        qDebug() << "XML error:" << xmlReader.errorString();
        return false;
    }

    file.close();
    return true;
}

// 获取字段定义列表
QList<FieldDefinition> XMLProtocolParser::getFieldDefinitions() const {
    return fieldDefinitions;
}

// 获取协议配置信息
ProtocolConfig XMLProtocolParser::getProtocolConfig() {
    return protocolConfig;
}
