#coding:utf8
import os,time,sys,getopt,threading

time = time.strftime("%Y-%m-%d-%h-%m-%s",time.localtime(time.time()))
def main(argv):
    global schem
    global configuration
    global targetName

    shortargs = 'c'
    longargs = ['schem=', 'configuration=', 'targetName=']
    opts, args = getopt.getopt(argv[1:], shortargs, longargs)
    print opts
    print args
    for op, value in opts:
        print value
        if op == '--schem':
            schem = value
        elif op == '--configuration':
            configuration = value;
        elif op == '--targetName':
            targetName = value
        else:
            print 'cuo'

    os.system("xcodebuild -project %s.xcodeproj -target %s -configuration %s -sdk iphoneos archive"%(schem,targetName,configuration))

if  __name__ == '__main__':
    main(sys.argv)
