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

INSERT INTO conversaciones_content (id_conversaciones_front, content) VALUES
(6, '[
  {
    "role": "Waiter",
    "agent_type": "system",
    "message": "Hello, welcome! What would you like to order?",
    "state": "done"
  },
  {
    "role": "Customer",
    "agent_type": "user",
    "message": "Hi, I''d like a coffee please.",
    "state": "wait"
  },
  {
    "role": "Waiter",
    "agent_type": "system",
    "message": "Certainly, would you like it hot or iced?",
    "state": "hide"
  },
  {
    "role": "Customer",
    "agent_type": "user",
    "message": "I''ll have it hot, thank you.",
    "state": "hide"
  },
  {
    "role": "Waiter",
    "agent_type": "system",
    "message": "Very well, please wait a moment.",
    "state": "hide"
  },
  {
    "role": "Customer",
    "agent_type": "user",
    "message": "Okay, thank you!",
    "state": "hide"
  }
]'),
(7, '[
    {
      "role": "Manager",
      "agent_type": "system",
      "message": "You''re late again? It''s already 10 o''clock.",
      "state": "done"
    },
    {
      "role": "Employee",
      "agent_type": "user",
      "message": "I''m sorry manager, there was a subway malfunction today and I waited for a long time.",
      "state": "wait"
    },
    {
      "role": "Manager",
      "agent_type": "system",
      "message": "You should leave earlier. This affects work efficiency.",
      "state": "hide"
    },
    {
      "role": "Employee",
      "agent_type": "user",
      "message": "I understand, I''ll leave earlier in the future to be on time.",
      "state": "hide"
    },
    {
      "role": "Manager",
      "agent_type": "system",
      "message": "I hope this is the last time. Go ahead and start your work now.",
      "state": "hide"
    },
    {
      "role": "Employee",
      "agent_type": "user",
      "message": "Okay, thank you for your understanding.",
      "state": "hide"
    }
  ]'),
(8, '[
  {
    "role": "Shop Assistant",
    "agent_type": "system",
    "message": "Hello, can I help you find something?",
    "state": "done"
  },
  {
    "role": "Customer",
    "agent_type": "user",
    "message": "Hi, I''m looking for sugar-free soy milk and organic oatmeal.",
    "state": "wait"
  },
  {
    "role": "Shop Assistant",
    "agent_type": "system",
    "message": "The sugar-free soy milk is in the third row of the beverage section. The organic oatmeal is on the left side of the grains section.",
    "state": "hide"
  },
  {
    "role": "Customer",
    "agent_type": "user",
    "message": "Thank you! Also, do you have a discount products section?",
    "state": "hide"
  },
  {
    "role": "Shop Assistant",
    "agent_type": "system",
    "message": "Yes, on the shelves next to the checkout counter - all discounted products are there.",
    "state": "hide"
  },
  {
    "role": "Customer",
    "agent_type": "user",
    "message": "Great, I''ll take a look. Can I use digital payment at checkout?",
    "state": "hide"
  },
  {
    "role": "Shop Assistant",
    "agent_type": "system",
    "message": "Of course, we accept WeChat Pay, Alipay and bank cards.",
    "state": "hide"
  },
  {
    "role": "Customer",
    "agent_type": "user",
    "message": "Thank you for your help, the service is excellent.",
    "state": "hide"
  },
  {
    "role": "Shop Assistant",
    "agent_type": "system",
    "message": "You''re welcome, have a pleasant shopping experience!",
    "state": "hide"
  }
]'),
(9, '[
  {
    "role": "Teacher",
    "agent_type": "system",
    "message": "Hello everyone, welcome to Chinese class! I''m your teacher.",
    "state": "done"
  },
  {
    "role": "Student",
    "agent_type": "user",
    "message": "Hello teacher! I''m a new student.",
    "state": "wait"
  },
  {
    "role": "Teacher",
    "agent_type": "system",
    "message": "Hello! May I know your name?",
    "state": "hide"
  },
  {
    "role": "Student",
    "agent_type": "user",
    "message": "My name is Martin. Nice to meet everyone!",
    "state": "hide"
  },
  {
    "role": "Teacher",
    "agent_type": "system",
    "message": "Welcome Martin. Please take a seat, we''ll start the class shortly.",
    "state": "hide"
  },
  {
    "role": "Student",
    "agent_type": "user",
    "message": "Okay, thank you teacher.",
    "state": "hide"
  }
]'),
(10, '[
  {
    "role": "Colleague A",
    "agent_type": "system",
    "message": "Hello, today is your first day at work, right? Welcome to our team!",
    "state": "done"
  },
  {
    "role": "New Colleague",
    "agent_type": "user",
    "message": "Hello, thank you! My name is Li Na, pleased to meet everyone.",
    "state": "wait"
  },
  {
    "role": "Colleague A",
    "agent_type": "system",
    "message": "I''m Wang Ming, I work in the marketing department. If you have any questions, feel free to ask me.",
    "state": "hide"
  },
  {
    "role": "New Colleague",
    "agent_type": "user",
    "message": "That''s great, thank you for your help! The atmosphere here is very nice.",
    "state": "hide"
  },
  {
    "role": "Colleague A",
    "agent_type": "system",
    "message": "Yes, our team is very friendly. Would you like to have lunch together?",
    "state": "hide"
  },
  {
    "role": "New Colleague",
    "agent_type": "user",
    "message": "Sure, I''d love to join you.",
    "state": "hide"
  }
]');

INSERT INTO conversaciones_content (id_conversaciones_front, content) VALUES
(11, '[
  {
    "role": "Garçom",
    "agent_type": "system",
    "message": "Olá, bem-vindo! O que você gostaria de pedir?",
    "state": "done"
  },
  {
    "role": "Cliente",
    "agent_type": "user",
    "message": "Oi, eu gostaria de um café, por favor.",
    "state": "wait"
  },
  {
    "role": "Garçom",
    "agent_type": "system",
    "message": "Claro, você quer quente ou gelado?",
    "state": "hide"
  },
  {
    "role": "Cliente",
    "agent_type": "user",
    "message": "Quero quente, obrigado.",
    "state": "hide"
  },
  {
    "role": "Garçom",
    "agent_type": "system",
    "message": "Certo, aguarde um momento.",
    "state": "hide"
  },
  {
    "role": "Cliente",
    "agent_type": "user",
    "message": "Ok, obrigado!",
    "state": "hide"
  }
]'),
(12, '[
    {
      "role": "Gerente",
      "agent_type": "system",
      "message": "Você está atrasado de novo? Já são 10 horas.",
      "state": "done"
    },
    {
      "role": "Funcionário",
      "agent_type": "user",
      "message": "Desculpe, gerente, hoje teve um problema no metrô e eu fiquei esperando muito tempo.",
      "state": "wait"
    },
    {
      "role": "Gerente",
      "agent_type": "system",
      "message": "Você deveria sair mais cedo. Isso afeta a produtividade.",
      "state": "hide"
    },
    {
      "role": "Funcionário",
      "agent_type": "user",
      "message": "Eu entendo, vou sair mais cedo no futuro para chegar no horário.",
      "state": "hide"
    },
    {
      "role": "Gerente",
      "agent_type": "system",
      "message": "Espero que seja a última vez. Vá começar seu trabalho agora.",
      "state": "hide"
    },
    {
      "role": "Funcionário",
      "agent_type": "user",
      "message": "Certo, obrigado pela compreensão.",
      "state": "hide"
    }
  ]'),
(13, '[
  {
    "role": "Atendente",
    "agent_type": "system",
    "message": "Olá, posso ajudar a encontrar algo?",
    "state": "done"
  },
  {
    "role": "Cliente",
    "agent_type": "user",
    "message": "Oi, estou procurando leite de soja sem açúcar e aveia orgânica.",
    "state": "wait"
  },
  {
    "role": "Atendente",
    "agent_type": "system",
    "message": "O leite de soja sem açúcar está na terceira prateleira da seção de bebidas. A aveia orgânica fica no lado esquerdo da seção de grãos.",
    "state": "hide"
  },
  {
    "role": "Cliente",
    "agent_type": "user",
    "message": "Obrigado! A propósito, vocês têm uma seção de produtos em promoção?",
    "state": "hide"
  },
  {
    "role": "Atendente",
    "agent_type": "system",
    "message": "Temos sim, nas prateleiras perto do caixa - todos os produtos em promoção estão lá.",
    "state": "hide"
  },
  {
    "role": "Cliente",
    "agent_type": "user",
    "message": "Ótimo, vou dar uma olhada. Posso pagar com pix no caixa?",
    "state": "hide"
  },
  {
    "role": "Atendente",
    "agent_type": "system",
    "message": "Claro, aceitamos Pix, cartões e dinheiro.",
    "state": "hide"
  },
  {
    "role": "Cliente",
    "agent_type": "user",
    "message": "Obrigado pela ajuda, o atendimento foi excelente.",
    "state": "hide"
  },
  {
    "role": "Atendente",
    "agent_type": "system",
    "message": "De nada, boas compras!",
    "state": "hide"
  }
]'),
(14, '[
  {
    "role": "Professor",
    "agent_type": "system",
    "message": "Olá a todos, bem-vindos à aula de português! Eu sou seu professor.",
    "state": "done"
  },
  {
    "role": "Aluno",
    "agent_type": "user",
    "message": "Bom dia, professor! Eu sou novo aqui.",
    "state": "wait"
  },
  {
    "role": "Professor",
    "agent_type": "system",
    "message": "Olá! Qual é o seu nome?",
    "state": "hide"
  },
  {
    "role": "Aluno",
    "agent_type": "user",
    "message": "Meu nome é João. Prazer em conhecer todos!",
    "state": "hide"
  },
  {
    "role": "Professor",
    "agent_type": "system",
    "message": "Bem-vindo, João. Por favor, sente-se, vamos começar a aula em breve.",
    "state": "hide"
  },
  {
    "role": "Aluno",
    "agent_type": "user",
    "message": "Certo, obrigado professor.",
    "state": "hide"
  }
]'),
(15, '[
  {
    "role": "Colega A",
    "agent_type": "system",
    "message": "Olá, hoje é seu primeiro dia de trabalho, não é? Bem-vinda ao nosso time!",
    "state": "done"
  },
  {
    "role": "Nova Colega",
    "agent_type": "user",
    "message": "Oi, obrigada! Meu nome é Ana, prazer em conhecer todos.",
    "state": "wait"
  },
  {
    "role": "Colega A",
    "agent_type": "system",
    "message": "Eu sou o Carlos, trabalho no departamento de marketing. Se tiver alguma dúvida, pode me perguntar.",
    "state": "hide"
  },
  {
    "role": "Nova Colega",
    "agent_type": "user",
    "message": "Que ótimo, obrigada pela ajuda! O clima aqui parece muito bom.",
    "state": "hide"
  },
  {
    "role": "Colega A",
    "agent_type": "system",
    "message": "Sim, nosso time é muito unido. Quer almoçar junto hoje?",
    "state": "hide"
  },
  {
    "role": "Nova Colega",
    "agent_type": "user",
    "message": "Adoraria, com certeza!",
    "state": "hide"
  }
]');


CREATE VIEW vw_users_interests
AS select u.*, s.videojuegos, s.peliculas, s.series, s.moda, s.travel, s.anime, s.ai, s.tecnologia from usuarios u 
join intereses s on u.id = s.usuario_id;
