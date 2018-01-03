
[pipeline 样例文件](https://jenkins.io/doc/pipeline/tour/running-multiple-steps/)


example of jenkinsfile

/*Declarative Pipeline*/
pipeline {
    /*directives,such as agent,environment, statges, post */
    /*The agent section specifies where the entire Pipeline, or a specific stage, will execute in the Jenkins environment depending on where the agent section is placed.*/
    agent any
    /*The environment directive specifies a sequence of key-value pairs which will be defined as environment variables*/
    environment {
            CC = 'clang'
    }
    /* The parameters directive provides a list of parameters which a user should provide when triggering the Pipeline. */
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    }
    /*The triggers directive defines the automated ways in which the Pipeline should be re-triggered.*/
    triggers {
        /* Accepts a cron-style string to define a regular interval at which the Pipeline should be re-triggered*/
        cron('H 4/* 0 0 1-5')
    }
    /*The options directive allows configuring Pipeline-specific options from within the Pipeline itself.*/
    options {
        timeout(time: 1, unit: 'HOURS')
    }
    stages {
        stage('Test') {
            environment {
                /*The environment block has a helper method credentials() defined which can be used to access pre-defined Credentials by their identifier in the Jenkins environment.*/
                AN_ACCESS_KEY = credentials('my-prefined-secret-text')
            }
            steps {
                sh 'echo "Fail!"; exit 1'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}


jenkins 的 dev pipeline 默认 pwd
/var/lib/jenkins/workspace/dev

下面所有文件都必须写绝对路径,因为pwd 默认位置在 /var/lib/jenkins/workspace/dev 下
sh "/home/wwwroot/deploy/build.sh > /home/wwwroot/deploy/build.log 2>&1"





new item 等同与 new job

设置jenkins 密码
sudo passwd jenkins

以 jenkins 身份登录
sudo -i -u jenkins

jenkins 配置文件
/etc/default/jenkins


jenkins workdspace base dir
jenkins@ubuntu:~/workspace/game-of-life-default$



jenkins 相关信息
/usr/bin/daemon --name=jenkins --inherit --env=JENKINS_HOME=/var/lib/jenkins --output=/var/log/jenkins/jenkins.log --pidfile=/var/run/jenkins/jenkins.pid -- /usr/bin/java -Djava.awt.headless=true -jar /usr/share/jenkins/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=808


禁用了两个协议,jenkins, 如果有问题, 考虑改回来

Java Web Start Agent Protocol/1 (deprecated, unencrypted)
Agent Protocol/2 (deprecated, unencrypted)

jenkins 无法 ssh 连接是因为 本机的公钥没有拷贝到对方机器上, 所以 jenkin 远程发布代码应该采用的方式为先将 jenkin 所在的机器上的公钥拷贝的远程主机上, 然后凭借私钥登录远程主机上


jenkins 中, iptables 执行的命令

```
 sudo ufw allow 22/tcp
```

注意: ufw 不一定会预装


jenkins 注意事项:
jenkins 安装完扩展后要重新启动




jenins home
/var/lib/jenkins


工作区
/var/lib/jenkins/workspace/beeper_develper_platform

jenkins git branch 插件使用经验

jenkins 直接配置时候直接不选择 branch, 然后进行配置



