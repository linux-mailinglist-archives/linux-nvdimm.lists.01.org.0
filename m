Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CBD173834
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 14:22:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63CFF10FC36E3;
	Fri, 28 Feb 2020 05:23:49 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=74.6.131.123; helo=sonic311-13.consmr.mail.bf2.yahoo.com; envelope-from=lw3628517@gmail.com; receiver=<UNKNOWN> 
Received: from sonic311-13.consmr.mail.bf2.yahoo.com (sonic311-13.consmr.mail.bf2.yahoo.com [74.6.131.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7D431007B191
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 05:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582896173; bh=zI0m+DRhZDm01EKX+YHsQU600DuE8AwybL7Vu4lblwE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ZXBjVvyPzfsJJI8WmgivXcG1IpYanQHk/y4WZsZc1rnLg426UQtyWasMxnhUQpF9ysRCjb0tpUeqczbvEeQP7sC7p5KEKy4p+qf0G4L+X75X/2SbZgwiGq6Nt20NpJix/7jV+O6Mgr8tum6uDknFC8UrN0QIsiRUdSNb5HjSb8EQaMvKl2Q0y5EeYIrcz7BQawcz4kiseC2dcbbtpsTvlX+L1FmCjAgSuHNGodxh7QudSsl+ANUny+cAF4/JwYD671mM5QpQWB+w149IXOUpoRwdxZpLfSU4RY0FSZg9RXFmrq57cLjr5+bxH+41tFN91iWwVvXbNISfj4sZkCRU6g==
X-YMail-OSG: EjW2WpEVM1nEwsGyqzNFpUe4iMZhGj_AfQ7qGkFelrAvAkKhlxCeVoAuyErYTgv
 bUYs2FHyY.k0XlvTyW4hSVPkotHzX5EzUzTynQ.QWZxhl2S341o9LCJDbrq6leumgzhXHZNfRw5M
 GnCFaHZxXpfFaaUaTVmUm.yoED0b4WGcFxIwYq7LpLioJWyj42gtoJavWzHYgDTZ8nQbi3Wh9Rxh
 X67NqW0OYU9.jKFEhCBvibmGwEyvbLYW.Lho_xaF.iS266qMEQeuLoZ_wcM4sfGsbwfOGCrRFNij
 8uJuVeI9zTXaT3VY1Z5.sUWFnoHGO8xq4FhfgiCedi1ouTl4gP6..URI7.oztic7GFWJm4GNqb_Q
 .MXkG1IJ1gIuRiridjlCrOptf2rtTpbtmE04TRBOGy5Y8SZ0vZ66u0JA8tPuNrnkC4OlcTR6K1_4
 vnXEmZUeshU4___3Q218ylLSCDFcR7b_VbR7BAsn1FQk54inNJ9zLYPw_Ts85TxCac69hpJ8tNSt
 accyJ2f281SbTx8cp3SynUJ9b62geb1yxyX.dEclySFEy35JvPyW83oiyYztcs6_XOl1.WXpbcak
 eFOA5eYg2ZGQ9965HRoqyL6xsoqvEagLmahR.zEDnn9nUtlcwdFVPt5kKXReB85sIJhEfqYQinn9
 k9gH0s6V0cQv7oLzAMVQIrKq2NeOZJxHYq5Ryso2ecDpHTvgWes3LMJXybJHCuJYKxZt3u5TKfA9
 6SOH_k3ctKl0CZuXU64XwMjyP_YYpUjbbPbFZZcZsi8MYqz0QzoZwH120eDQ_RMS5NiowNuSwcX8
 OMF2.PjsjygOapwbnbxfDEhyp3IthCmxwQKkHzme1YW_X2PaoV2sXnDbapE8iCl.ALfGHNr8rzQ3
 _dK0vumVk5.TTwMiE.N5b__efET2j1PUXqvpp4xsqPHa9AjozxQhDBP4EIt9Ke8OYxnLSg7NdZv.
 KQmEmyB_1tnbIbizfp6DhxKFexeFZoxlefAtr5YIhXizEsHj5iKeDIiPc8REJ1hECGEm_n8y7baT
 CquEyqyWDnPQCGIVW26FgdehLKfWLWjyus5k_.xqAn._6xXKib3STbLEDpXOjbWuHZjOhhUn7Jt9
 L2.B8pO1DiZXBUcN_HwFLHmFS__czA9YifSuYTEtPzHV652VMbhksaNzxLwo509iuvHnMD.RK_rl
 1CosPvityee_Oq7aT_7DJW6tSttyFKqtYbAWllky.ifH5.aCOKKTatiSvfxninGGMA2lW5CthGcb
 _Ns4h.AWvO2_QbOJe1URZ489rPfyrzJCgvnT4uhARVAXSGqw_zY3i2CmBRftBgq8dmCRmqEAfLcs
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 28 Feb 2020 13:22:53 +0000
Date: Fri, 28 Feb 2020 13:22:52 +0000 (UTC)
From: Lisa Williams <lw3628517@gmail.com>
Message-ID: <245385345.1333082.1582896172571@mail.yahoo.com>
Subject: Hi Dear
MIME-Version: 1.0
References: <245385345.1333082.1582896172571.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15302 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:73.0) Gecko/20100101 Firefox/73.0
Message-ID-Hash: 2A4NXPNXEAFCSDVPOCDKW4XPII3MMHMF
X-Message-ID-Hash: 2A4NXPNXEAFCSDVPOCDKW4XPII3MMHMF
X-MailFrom: lw3628517@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: lisawilam@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2A4NXPNXEAFCSDVPOCDKW4XPII3MMHMF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Hi Dear,

 How are you doing hope you are fine and OK?

I was just going through the Internet search when I found your email address, I want to make a new and special friend, so I decided to contact you to see how we can make it work out if we can. Please I wish you will have the desire with me so that we can get to know each other better and see what happens in future.

My name is Lisa Williams, I am an American, but presently I live in the UK, I will be glad to see your reply for us to know each other better to exchange pictures and details about us.

Yours
Lisa
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
