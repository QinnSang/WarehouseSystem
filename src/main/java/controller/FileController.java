package controller;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import pojo.Contract;
import service.ContractService;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    ContractService contractService;

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
            //2. 获取文件后缀
            String after=originName.substring(originName.lastIndexOf(".")+1);
            //3. 文件重命名来防止上传文件重名产生覆盖：将原文件名+时间戳
            String newFileName=originName+"_"+new Date().getTime()+"@"+after;
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

    @RequestMapping("/downloadContract")
    public ResponseEntity<byte[]> downloadContract(Integer contractId, HttpServletResponse response)throws Exception{
        // 根据id查询文档
        Contract contract=contractService.queryByContractId(contractId);
        // 上传文件路径
        String fileUrl = contract.getFileUrl();
        // 获得要下载文件的File对象
        File file = new File(fileUrl);
        //获取文件后缀
        String after=fileUrl.substring(fileUrl.lastIndexOf("@")+1);
        //获得文件名
        String fileName=contract.getContractName();
        // 下载显示的文件名，解决中文名称乱码问题
        String downloadFileName = null;
        downloadFileName = new String((fileName+"."+after).getBytes("UTF-8"),"iso-8859-1");
        // 创建springframework的HttpHeaders对象，设置响应头通知浏览器下载
        HttpHeaders headers = new HttpHeaders();
        // 通知浏览器以attachment（下载方式）打开
        headers.setContentDispositionFormData("attachment", downloadFileName);
        // application/octet-stream ： 二进制流数据（最常见的文件下载）。
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        // 201 HttpStatus.CREATED
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
    }

}
