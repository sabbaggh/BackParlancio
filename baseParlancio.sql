select * from usuarios;
select * from intereses;

CREATE TABLE conversaciones_front (
    id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    language VARCHAR(10) NOT NULL,
    level VARCHAR(20) NOT NULL,
    image TEXT
);

INSERT INTO conversaciones_front (id, title, language, level, image) VALUES
(1, 'Ordenar un cafe', 'cn', 'beginner', 'https://img-cdn.inc.com/image/upload/f_webp,q_auto,c_fit/images/panoramic/GettyImages-1318950018_535375_uwicaq.jpg'),
(2, 'Llegar tarde al trabajo', 'cn', 'intermediate', 'https://nypost.com/wp-content/uploads/sites/2/2025/01/office-worker-coming-late-meeting-97303488.jpg?quality=75&strip=all'),
(3, 'Ir al supermercado', 'cn', 'advanced', 'https://www.mashed.com/img/gallery/the-best-worst-days-to-grocery-shop/l-intro-1679673392.jpg'),
(4, 'Primer dia de clases', 'cn', 'beginner', 'https://www.parentmap.com/sites/default/files/styles/1180x660_scaled_cropped/public/2024-08/girl%20on%20first%20day%20of%20school%20holding%20a%20sign_istock.jpg?itok=5yOyTbBM'),
(5, 'Conociendo nuevos colegas', 'cn', 'intermediate', 'https://www.rwrecruitment.com/wp-content/uploads/2019/09/Getting-to-know-your-colleagues-in-a-new-job.jpg');

INSERT INTO conversaciones_front (id, title, language, level, image) VALUES
(6, 'Ordenar un cafe', 'en', 'beginner', 'https://img-cdn.inc.com/image/upload/f_webp,q_auto,c_fit/images/panoramic/GettyImages-1318950018_535375_uwicaq.jpg'),
(7, 'Llegar tarde al trabajo', 'en', 'intermediate', 'https://nypost.com/wp-content/uploads/sites/2/2025/01/office-worker-coming-late-meeting-97303488.jpg?quality=75&strip=all'),
(8, 'Ir al supermercado', 'en', 'advanced', 'https://www.mashed.com/img/gallery/the-best-worst-days-to-grocery-shop/l-intro-1679673392.jpg'),
(9, 'Primer dia de clases', 'en', 'beginner', 'https://www.parentmap.com/sites/default/files/styles/1180x660_scaled_cropped/public/2024-08/girl%20on%20first%20day%20of%20school%20holding%20a%20sign_istock.jpg?itok=5yOyTbBM'),
(10, 'Conociendo nuevos colegas', 'en', 'intermediate', 'https://www.rwrecruitment.com/wp-content/uploads/2019/09/Getting-to-know-your-colleagues-in-a-new-job.jpg');

INSERT INTO conversaciones_front (id, title, language, level, image) VALUES
(11, 'Ordenar un cafe', 'pt', 'beginner', 'https://img-cdn.inc.com/image/upload/f_webp,q_auto,c_fit/images/panoramic/GettyImages-1318950018_535375_uwicaq.jpg'),
(12, 'Llegar tarde al trabajo', 'pt', 'intermediate', 'https://nypost.com/wp-content/uploads/sites/2/2025/01/office-worker-coming-late-meeting-97303488.jpg?quality=75&strip=all'),
(13, 'Ir al supermercado', 'pt', 'advanced', 'https://www.mashed.com/img/gallery/the-best-worst-days-to-grocery-shop/l-intro-1679673392.jpg'),
(14, 'Primer dia de clases', 'pt', 'beginner', 'https://www.parentmap.com/sites/default/files/styles/1180x660_scaled_cropped/public/2024-08/girl%20on%20first%20day%20of%20school%20holding%20a%20sign_istock.jpg?itok=5yOyTbBM'),
(15, 'Conociendo nuevos colegas', 'pt', 'intermediate', 'https://www.rwrecruitment.com/wp-content/uploads/2019/09/Getting-to-know-your-colleagues-in-a-new-job.jpg');

CREATE TABLE conversaciones_content(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_conversaciones_front INT,
    content JSON
);

INSERT INTO conversaciones_content (id_conversaciones_front, content) VALUES
(1, '[
  {
    "role": "服务员",
    "agent_type": "system",
    "message": "你好，欢迎光临！请问你要点什么？",
    "state": "done"
  },
  {
    "role": "顾客",
    "agent_type": "user",
    "message": "你好，我想要一杯咖啡。",
    "state": "wait"
  },
  {
    "role": "服务员",
    "agent_type": "system",
    "message": "好的，请问你要热的还是冰的？",
    "state": "hide"
  },
  {
    "role": "顾客",
    "agent_type": "user",
    "message": "我要热的，谢谢。",
    "state": "hide"
  },
  {
    "role": "服务员",
    "agent_type": "system",
    "message": "好的，请稍等。",
    "state": "hide"
  },
  {
    "role": "顾客",
    "agent_type": "user",
    "message": "好的，谢谢！",
    "state": "hide"
  }
]'),
(2, '[
    {
      "role": "经理",
      "agent_type": "system",
      "message": "你怎么又迟到了？已经十点了。",
      "state": "done"
    },
    {
      "role": "员工",
      "agent_type": "user",
      "message": "对不起经理，今天地铁故障了，我等了很久。",
      "state": "wait"
    },
    {
      "role": "经理",
      "agent_type": "system",
      "message": "你应该提前出门。这样会影响工作效率。",
      "state": "hide"
    },
    {
      "role": "员工",
      "agent_type": "user",
      "message": "我明白了，以后我会早点出门，保证准时。",
      "state": "hide"
    },
    {
      "role": "经理",
      "agent_type": "system",
      "message": "希望这是最后一次。赶快去开始你的工作吧。",
      "state": "hide"
    },
    {
      "role": "员工",
      "agent_type": "user",
      "message": "好的，谢谢经理的理解。",
      "state": "hide"
    }
  ]'),
(3, '[
  {
    "role": "店员",
    "agent_type": "system",
    "message": "您好，请问需要帮忙找什么吗？",
    "state": "done"
  },
  {
    "role": "顾客",
    "agent_type": "user",
    "message": "你好，我在找无糖豆奶，还有有机燕麦片。",
    "state": "wait"
  },
  {
    "role": "店员",
    "agent_type": "system",
    "message": "无糖豆奶在饮品区的第三排。有机燕麦片在谷物区的左边。",
    "state": "hide"
  },
  {
    "role": "顾客",
    "agent_type": "user",
    "message": "谢谢！另外，请问你们有没有打折商品区域？",
    "state": "hide"
  },
  {
    "role": "店员",
    "agent_type": "system",
    "message": "有的，在收银台旁边的货架上，所有打折商品都在那里。",
    "state": "hide"
  },
  {
    "role": "顾客",
    "agent_type": "user",
    "message": "太好了，我去看看。结账可以用电子支付吗？",
    "state": "hide"
  },
  {
    "role": "店员",
    "agent_type": "system",
    "message": "当然，我们支持微信、支付宝和银行卡。",
    "state": "hide"
  },
  {
    "role": "顾客",
    "agent_type": "user",
    "message": "谢谢你的帮助，服务很好。",
    "state": "hide"
  },
  {
    "role": "店员",
    "agent_type": "system",
    "message": "不客气，祝您购物愉快！",
    "state": "hide"
  }
]'),
(4, '[
  {
    "role": "老师",
    "agent_type": "system",
    "message": "大家好，欢迎来到中文课！我是你们的老师。",
    "state": "done"
  },
  {
    "role": "学生",
    "agent_type": "user",
    "message": "老师好！我是新来的学生。",
    "state": "wait"
  },
  {
    "role": "老师",
    "agent_type": "system",
    "message": "你好！请问你叫什么名字？",
    "state": "hide"
  },
  {
    "role": "学生",
    "agent_type": "user",
    "message": "我叫马丁。很高兴认识大家！",
    "state": "hide"
  },
  {
    "role": "老师",
    "agent_type": "system",
    "message": "欢迎你，马丁。请坐吧，我们马上开始上课。",
    "state": "hide"
  },
  {
    "role": "学生",
    "agent_type": "user",
    "message": "好的，谢谢老师。",
    "state": "hide"
  }
]'),
(5, '[
  {
    "role": "同事A",
    "agent_type": "system",
    "message": "你好，今天是你第一天上班吧？欢迎加入我们团队！",
    "state": "done"
  },
  {
    "role": "新同事",
    "agent_type": "user",
    "message": "你好，谢谢你！我叫李娜，很高兴认识大家。",
    "state": "wait"
  },
  {
    "role": "同事A",
    "agent_type": "system",
    "message": "我叫王明，我在市场部工作。如果你有问题，随时可以问我。",
    "state": "hide"
  },
  {
    "role": "新同事",
    "agent_type": "user",
    "message": "太好了，谢谢你的帮助！这里的氛围很好。",
    "state": "hide"
  },
  {
    "role": "同事A",
    "agent_type": "system",
    "message": "是的，我们团队很友善。中午一起去吃饭吧？",
    "state": "hide"
  },
  {
    "role": "新同事",
    "agent_type": "user",
    "message": "好啊，我很乐意一起去。",
    "state": "hide"
  }
]');
