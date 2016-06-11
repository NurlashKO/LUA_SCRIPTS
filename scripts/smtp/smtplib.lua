printdir(1)
collectgarbage();
rst = smtp.config("smtp.163.com",25,"songjin_hello","123456");
print("rst of smtp.config=", rst, "\r\n");
rst = smtp.set_from("<songjin_hello@163.com>", "");
print("rst of smtp.set_from=", rst, "\r\n");
rst = smtp.set_rcpt(0,0,"<jin.song@sim.com>", "");
print("rst of smtp.set_rcpt=", rst, "\r\n");
rst = smtp.set_rcpt(0,1,"<jin.song.hello@gmail.com>", "");
print("rst of smtp.set_rcpt=", rst, "\r\n");
rst = smtp.set_subject("my mail subject");
print("rst of smtp.set_subject=", rst, "\r\n");
rst = smtp.set_body("this is the first mail");
print("rst of smtp.set_body=", rst, "\r\n");
rst = smtp.set_file(1, "c:\\6K.jpg");
print("rst of smtp.set_file=", rst, "\r\n");
print("smtp sending now...\r\n");
rst = smtp.send();
print("rst of smtp.send=", rst, "\r\n");