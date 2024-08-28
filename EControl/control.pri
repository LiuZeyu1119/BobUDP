INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD

SOURCES += \
    $$PWD/general/EClipBoard.cpp \
    $$PWD/general/MyColor.cpp \
    $$PWD/general/MyFont.cpp \

HEADERS += \
    $$PWD/general/EClipBoard.h \
    $$PWD/general/MyColor.h \
    $$PWD/general/MyFont.h

RESOURCES += \
    $$PWD/EControl.qrc \
    $$PWD/font.qrc \

QML_IMPORT_PATH += \
    $$PWD

