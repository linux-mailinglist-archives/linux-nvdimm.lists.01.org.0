Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA0185681
	for <lists+linux-nvdimm@lfdr.de>; Sat, 14 Mar 2020 23:18:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2596310FC36E4;
	Sat, 14 Mar 2020 15:19:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.238.176.99; helo=sonic301-22.consmr.mail.ir2.yahoo.com; envelope-from=mark_esq@yahoo.fr; receiver=<UNKNOWN> 
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8777D1007B1C5
	for <linux-nvdimm@lists.01.org>; Sat, 14 Mar 2020 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048; t=1584224303; bh=yQ8j5nOiL1AB9VzjpcatQY3Gp/1Xq/WgkFt4Qo+Pvao=; h=Date:From:Reply-To:Subject:References:From:Subject; b=P/6HbzjV0X7fJWb3nu+uZG0vX+yglM9sXq8vxv1qnAHDN28tdMhvvSrbIunvvP7Sc61bLI210kcb7A0/+zN2PeukBtXgLLnAO6b9fgcML4qEDGma9s/2Jh4n1dmQWIdPCvJtDl9FNKlmS9m7K54Z/NIkXC+9Xk55uxoOe3nG0xfgNzU8INFkvWXOUFEa0N1bdH3/huDEW7OJxDJce+cTdd9d7+LzrVwoZuHdkEPn1mDgE3BpMUMMqKO4+YvOpNl8K8gxF5d+d/3twk07SHmpGJk7eXhzd7IONRlEUFADzE6jadIa+QukebqfEmNoMC0m6ZtI/JVp3RasGnJw17OcDw==
X-YMail-OSG: b7nZ1BMVM1kCV.Cvyy4Z9r1cLpSeD.So3av.w9RCH_uAWgq6cj74QyX2FPk1_00
 y_4RWX25Mtho0oyHMZgjJn4OsoQsTiPN7xurOM7j60y85R7Q42W1Vq8NFlfrnPGDPh9KfGM_QyZh
 EMSaPglm.rk4y4n6HSoMG40XHMAnQcPZLk3Z4e3JYUyQRsJ0UroT4fsI0qRCjq_VdFWsrDl_Bw.n
 _DK3R1WUQU_GUB9yQ2TkJfU1bwZNeguBBraoFfzNZmmtRpqtendXUVzg_RNQNEvA4oQgylucnkHS
 1Dx0qnKwUcwmNB_Ah5LNPbSlqVQiBIEkM8CyiVVO3pFSkZNp65.qZmhLgr42Iey8Lpt19FylKFkH
 eAFBSOy.EeeaRB9ser3lMRZuOjVXk.LHwWFBeMxOKUasJ3IcxJGQ5Bu7Fko0CFrI1Ley4tbisgBs
 gDjo3bvplSW1jAKg3JAegJHmVg7_JAvVF8JDYc6QeH7ELk.9KeN9S6.jL.to5n339W6g.hVgD4Cc
 nn6Ey20d1Lv1bFHVdDbkolKXldy.Fs1Bz.hp2N8oAw8KkrzqZeJD9LbTxlIb4Sp5DlWNXYqJdPne
 wo9mVuyiyF106GTHIWc58ZFMsqG5ONj34Wz8UbnxbAzHUUNuCuZkh37PmELMSO6Q.Ijv_bK2IKkQ
 cgLf0qlTIQKEkQ29m2Hnnt_tKj1cTfsCZwDtv3yViDBEciqnXINRJjlQUbpe0_vItvfgtEk3kKAd
 F7K6hspx2WH.KCCimTbmd2ze.LyPqaAVQwF7Y8Jhb01CvzO9B8kTB0TyNHobEYL.qseFLp6pm5e3
 tt0hgT_MVcwHPCZpowZ1KtFHLZBffSgFMV055Jwqkcf_XQkD.MmZh1Fjxo9vD.Ta_UTIhgrt6wnO
 XBBfyu4604.CwjiCiR4rCUEy5STQf9QNY762MPcgTawTnMeichMLZd1Mg_JwQv9fItMGwNMYvs4Z
 ZgtNOnbBaptKT6fl8ZBdWLVcocs5ARKPXdICV_mwlnlIXMWjHh7ysPnTJM8EVoL.u1ftnwEwjK9j
 efHjh3r5J6KDgfCZRUH68Gl76JkDur4RmrowImdxlQ.QxZTnMQA5ZXpimKstYiY4T7E0r_DrJPY2
 RjtdOrmgEgwEj798FajgggXqBmQvt_X5gPvotugF0S9LBVFWVQ9CNJhR3bEPB6xDj.lMzc.YJwWR
 xz1rawAakzglR.pcuCT5wb8ANwvKAxE1Z2FouXqoOyelsWkmSRKzNoqCfSDYX9n8snSLpynIpVhl
 UnBN4UQjnVhq962GObnx2kLtcO0nSvG9B5gIxznr1.iGtbOdoM8FAnsVFKMq8Y.kQ737hT0s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sat, 14 Mar 2020 22:18:23 +0000
Date: Sat, 14 Mar 2020 22:18:20 +0000 (UTC)
From: Olatunji Martins <mark_esq@yahoo.fr>
Message-ID: <1927746491.1296012.1584224300931@mail.yahoo.com>
Subject: Greetings
MIME-Version: 1.0
References: <1927746491.1296012.1584224300931.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0
Message-ID-Hash: 3QRU2HFKY3PR5C4OHLS6QHDFXCSE37SZ
X-Message-ID-Hash: 3QRU2HFKY3PR5C4OHLS6QHDFXCSE37SZ
X-MailFrom: mark_esq@yahoo.fr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: barrolatunjimartins@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3QRU2HFKY3PR5C4OHLS6QHDFXCSE37SZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Greetings I am Barrister Olatunji Martins, personal attorney to my late client who left the sum of 10.5million dollars in his account and die along with his family. so i need a serious person who is willing and capable to work with me with honest and trust to enable us proceed in details. Barrister Olatunji Martins,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
