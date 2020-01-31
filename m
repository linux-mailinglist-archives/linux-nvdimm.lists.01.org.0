Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD33614F534
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Feb 2020 00:31:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B06710FC3179;
	Fri, 31 Jan 2020 15:34:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=98.137.64.84; helo=sonic305-21.consmr.mail.gq1.yahoo.com; envelope-from=elpumita@ymail.com; receiver=<UNKNOWN> 
Received: from sonic305-21.consmr.mail.gq1.yahoo.com (sonic305-21.consmr.mail.gq1.yahoo.com [98.137.64.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A55EB10FC3178
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jan 2020 15:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048; t=1580513456; bh=8xpm+cacAfAnFCbwSdgMceaBJxowNWaFZvEVU/zxgKw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=pq8QOaqykmcadwvX1Hn4KDnBXIONoybbZfgGY5TkTD/Y50ezbgfbKwb9nPsRfn3gXiXuUSIsQVhDaEgeIOIyW0lug+dYmHfCS4H5Pc5Tw2Ajtf94te0YJBwvtIyzy/nNdo0ToBUX2bRemCwpUKeD8uNe57wsDESirq8vpy77D7DYwMuHsFXDHZIEav9hhJAsuRigujtyfNeDxD6+6BmSf0Wmrkz06NG7LXAyM4ZcdUaeiN+j1+Q94GDkPcsWyRWgDgcNWsGe5mwtvTHStvxltxWPRurMNYOcOj7QN3juvG2fAOiUh7xR4uaTYzHlKtqsI8I7Dl9glJk36Q5wA1PNVg==
X-YMail-OSG: 7lAiTeQVM1nIWphFAcoMD89kkY7pwhncwdNVfYYhUkLl_MIX5keri4eB2Qd4TGI
 yaPw04KwCq950eqc3UCrdv50DnmbKUqOb4Mgl_J87.TqPeM4i_ZaLEzje7NDvCD7oQgAwG0Tp3Rf
 Gg.xoAPWNqmuo0txvfCMrb_b.XXmI1P0yUQ.yooq4257ctxigaeRA0uh_FNuRU2GXJV3it_Bw8yb
 jMVC589aECzA7MSfjzffEr9dWfORT5aeIAWuqf1RC0hJZRwuLPDygjaCy8AhYTw11ao6RP5pY4Re
 DsFrXYn.jNtXZW0xgTDFcFpUz8EZjZlSZeNAB2olAlSRctswsQFPLlfEIQPOxVDc5keGENNClwSG
 Tufh6fhAH2Iv.dD4gEqk8nJSGPQ_Z1WWJAC1f08U.Ceu.staAnAHriYkkkOqq76KYMCDY1neClq.
 qgcCqV3eV8BRJKEanxf3ZMQriR_ivY9lhQBJbyNEK7waaVxPvEYgzAd1m60XCfhkCtBK_ldv6crD
 qi1AOhRlv_LFcPTn3KEwsn6NgEAiz6KFavkWaYCIWRyIDKQMcYfu9Ww9neuBsOhbGSeUWK.lrk.Y
 kBnNcWgI_NX1xx34qMe6UEY50S5nEh2AaKF9PAuxGsLCFZvWn5cuL7NenAZcnhws7xjvw8zsdgXt
 slc0UA_YUEoeD..ZIvmlzaZqALFSXHIMvcsyPXdV26x1bzpdvKurFqdAFGmZ3A8oZahiVDSDt9kh
 v.l_.X4nscjujfpCPjA4aPSht4MuJufMAipS6E.IgtbD72fNnY8526Tn31dK3QpG2IRdlPhkkt3d
 7Lx3i5ma_LEVnhhHQSP5oHiXVhi3MottVwkz8hBdic7ES0FZSBoYo1qcPWCBDzZG6NvGQ0Y8laac
 3VwPUgylruincBhGN_7j2ws3C3AKRUHxGz7r1JTmw1zNNTTo8041vFEAiMxWtDmDveL0DI3UCkry
 eWm1XxZoU9yOWX8FD8ysX2M0YLHqVe4whYMv9qTofZkiWh8UpY62XdCp.L7gMXI.5ZLdHlY9wIkI
 awRaB_JkXIijAjB742otCMQ3Ii2gYwmpuFs4mwVJu3e_XfHgTJkt3rP1rHvJESbnR6VZzSzogpj6
 n0rGtUezgOeoz3j3sTObuI7IPynNUHFDNYNyoorpBAnlX17JTn9q5qndXc_Oi17q3QKRDfzgj_vy
 fVmOvLZRpv2q5JWI3bhH2UUU2AntLvCVESL3T1uQ4pE0qLjXPAUeHD3BQWBzJZrxvSLFTlP9L1ux
 qhVOjmJXQ_t85KysOs6DtphnU_dWZa.MkYkzmcdV04Py_Vt4mzLgAYHF1k7EA_80rSM2wwncPBYN
 ArA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 Jan 2020 23:30:56 +0000
Date: Fri, 31 Jan 2020 23:30:55 +0000 (UTC)
From: Cherif Titi <elpumita@ymail.com>
Message-ID: <130240372.70853.1580513455002@mail.yahoo.com>
Subject: My Dear
MIME-Version: 1.0
References: <130240372.70853.1580513455002.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15149 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0
Message-ID-Hash: 4F5ZV7HMXUES7L7MQU6OVP6KQ2DFU5T5
X-Message-ID-Hash: 4F5ZV7HMXUES7L7MQU6OVP6KQ2DFU5T5
X-MailFrom: elpumita@ymail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: cheriftiti268@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4F5ZV7HMXUES7L7MQU6OVP6KQ2DFU5T5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 My Dear

I am Miss cherif Titi,20 years old and the only daughter of my late parents Dr.Richard Tit. My father was a highly reputable real estate developer who operated in the capital city of Ivory coast during his days

It is sad to say that he passed away mysteriously in UK during one of his business trips abroad year 12th. JUNE 12, 2014. Though his sudden death, But God knows the truth! My mother died when I was just 4 years old,and since then my father took me so special Before his death on JUNE 12, 2014 he called his secretary who accompanied him to the hospital and told him that he has the sum of Nine million,five hundred thousand United State Dollars.(USD$9.500,000) left in bank

He further told him that he deposited the money in my name, and finally issued a written instruction to his lawyer whom he said is in possession of all the necessary legal documents to this fund

I am just 20 years old and a university undergraduate and really don't know what to do. Now I want an account overseas where I can transfer this funds. This is because I have suffered a lot of set backs as a result of incessant political crisis here in Ivory coast. The death of my father actually brought sorrow to my life

Dear, I am in a sincere desire of your humble assistance in this regards,Your suggestions and ideas will be highly regarded.


Now permit me to ask these few questions:

1. Can you honestly help me as your daughter

2. Can I completely trust you

3. What percentage of the total amount in question will be good for you after the money is in your account

Please contact me with my private email cheriftiti268@yahoo.com


Please,Consider this and get back to me as soon as possible.


My sincere regards,
Mrs.cherif TITI
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
