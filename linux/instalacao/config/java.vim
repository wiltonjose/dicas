function! AtualizaClassPath()
python << endpython
import vim
import os

pwd = os.getcwd()

def getTarget(path) :
    arquivo = open(path + '/project.properties', 'r')
    linhas = arquivo.readlines()
    for linha in linhas :
        linha = linha.strip()
        if linha.startswith('target=') :
            return linha[7:]
    return ''

def getClassPath(path) :
    arquivo = open(path + '/classpath', 'r')
    linhas = arquivo.readlines()
    c = []
    for linha in linhas :
        linha = linha.strip()
        if not linha :
            c.append(linha)
    if not c :
        return ''
    return ':'.join(c)

def getClassPathAndroid(path) :
    ANDROID_SDK = os.environ['ANDROID_SDK']
    if ANDROID_SDK == '':
        exit(1)
    target = getTarget(path)
    plataforma = '%s/platforms/%s/android.jar' % (ANDROID_SDK, target)
    suporte = '%s/extras/android/support/v4/android-support-v4.jar' % ANDROID_SDK
    return ':'.join([plataforma, suporte])

while not False :
    classpath = []
    if os.path.exists(pwd + '/classpath') :
        cp = getClassPath(pwd)
        if cp :
            classpath.append(cp)

    if os.path.exists(pwd + '/AndroidManifest.xml') :
        classpath.append(getClassPathAndroid(pwd))

    if classpath :
        classpath.append(os.environ['CLASSPATH'])
        vim.command("let $CLASSPATH = \'%s\'" % ':'.join(classpath))
        break

    i = pwd.rfind('/')
    if (i == -1) :
        break
    pwd = pwd[0:i]
    if pwd.endswith(os.environ['USER']) :
        break
endpython
endfunction

call AtualizaClassPath()
