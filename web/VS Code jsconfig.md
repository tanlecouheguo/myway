# VS Code 使用jsconfig.json文件配置`import`支持绝对路径导入
使用这种方式后，vs code仍然支持在文件中`转到定义`、`IntelliSense`、`Automatic Type Acquisition`等特性


    {
        "compilerOptions": {
            "baseUrl": ".",
            "paths": {
                "@/*": [
                    "./src/*"
                ]
            }
        },
        "include": [
            "src/**/*"
        ]
    }

使用上述规则之后`import`语句可以如下写使用

aa在src目录下面
-  修改之前

        import aa from '../../aa'

- 修改之后    
        
        imoprt aa from '@/aa'

结合webpack的`resolve`配置可以支持这种方式的打包

    resolve: {
        alias: {
            '@': path.resolve(__dirname, 'src')    //<== 这里，具体可以看resolve方法内部 @符合就代表了 磁盘中src的绝对路径
        }
    },
更多的jsconfig.json文件的配置，请查看[https://code.visualstudio.com/docs/languages/jsconfig](https://code.visualstudio.com/docs/languages/jsconfig)