package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/file")
public class FileController {

    /**
     * “异步上传”文件，即先让文件上传，再和其它表单一起提交保存
     */
    @RequestMapping("/uploadOneFile")
    @ResponseBody
    public Map<String,Object> uploadOnefile(@RequestParam("file") MultipartFile file){
        //todo 文件名前为什么多了个;
        String pathUpload="E:"+File.pathSeparator;
        Map<String,Object> map=new HashMap<>();
        //1.上传什么  2.传到哪里去  3.怎么传
        //判断上传的对象是否为空
        if(file!=null&&!file.isEmpty()){
            //1. 获取文件原始名字
            String originName=file.getOriginalFilename();
//            //2. 消除文件后缀，只保留文件名，作为显示的文件名（可省略），所以下载时不会有文件的格式
//            String showFileName=originName.substring(0,originName.lastIndexOf("."));
            //3. 文件重命名来防止上传文件重名产生覆盖：将原文件名+时间戳
            String newFileName=originName+"_"+new Date().getTime();
            //4. 构建文件对象
            File newFile=new File(pathUpload+newFileName);
            //5. 上传文件
            try {
                file.transferTo(newFile); //通过 transferTo() 方法将文件写入到磁盘上
                map.put("code",0);
                map.put("fileUrl",newFile);
                map.put("fileName",originName);
//                map.put("fileName",showFileName); //显示文件名和下载文件名不一致时使用
            } catch (IOException e) {
                map.put("code",1);
                e.printStackTrace();
            }
        }
        return  map;
    }

}
