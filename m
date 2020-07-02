Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CC212124
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Jul 2020 12:26:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D9BAB111F92B4;
	Thu,  2 Jul 2020 03:25:59 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=74.6.129.41; helo=sonic301-2.consmr.mail.bf2.yahoo.com; envelope-from=mariliis.manniik@gmail.com; receiver=<UNKNOWN> 
Received: from sonic301-2.consmr.mail.bf2.yahoo.com (sonic301-2.consmr.mail.bf2.yahoo.com [74.6.129.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B8498111E7BFA
	for <linux-nvdimm@lists.01.org>; Thu,  2 Jul 2020 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593685556; bh=ssuR219tc4zbcHmcubTL/XfCxjR+e0fxoJYqe5eUFts=; h=Date:From:Reply-To:Subject:References:From:Subject; b=WIWopW+BpLOwAmcikNwzHZMCRcLwgOwkzMDSXRS/xblCdOZF3QEJwlmPq9NYIg1Y88gztHzcwIKaZFhjNKOGyHqe9aVX9Vun06cpgvZ1ELeDsy41QXXoeRUqepWDV3mqn20UGhTogVBLRfa5L/5acrdpDf6HiO24IhUw3tBbS9Xc7t5DIRkvskCOEdzq5smSzhQM9J5433+PnR7rKHUWCWctbPy6vctTatQhOp9+2jFPcMka95fYqD5oQj8nYBNWJv1/KUk7fNUDN5qlM+xXHxfk3UkyVugCNNYYnqARtNROzKyweu0nSpQpjXiIaw8xaSAZSMnMWReFOxRZafTB4Q==
X-YMail-OSG: AGP90moVM1kWJQGFiyaCP._1uEQvXPIVk87PaMJHYW93eQ_7ycnNGHwF1qGeL82
 5ZYdswoqUqRmkhneTrIxcharSMx2XgZZD1PLkBZ_NM8kUIIcUjPKWJYpX0oepCbbFtSZ0t3ql_rt
 9KKewzlRQCZDGPAWr6zXYQfwn6lILf3LdPoqqiHpGhsti_d3G1LiRw9o338zNLDT_ZCtequmlRnU
 YhpA6dXp.mmo1EhEcpfdB.yzPZNQKbPm_M7mdm29UisRso.UbiiCgecYsyB5sHhTV0jO_XDi7fUG
 CWbr1cnXaQZyZI1HNZwyT2xGOccENwoY3yXq5_ltTQR0RlE04yFo2ZwKgtRuAtjq1Zf0cTanzTwj
 74cl_BSzsicMrquGhpOm9iJIO2bUIzDWK1_ZnUA8dBvMcrfMu8w20SszISc00XesU.qBMhApZcgc
 n5_B8z4CByu4.krC9Ml6H6clHS1b6hdEodAUPSFCGBtr0gzebSjTrkGBR7fCdbepk.aYgj.gwXsU
 0_XIY_4KazejQX8sPK07.0s3CbScnUZqtyAynyg1W5u4AYvAbm_XV1Pg3FmWQmc5oWmG17I_WnUz
 WsyjpcjPfDUgXTEberxzRMgn0rgkdHhZrfLpZB.J2bojyQz0iQgHsHRZALMgkgbFBNbEZcJ0RLGz
 BAnYXss6EsVXpVu1.nUnAoi1XU.v3GZgVNT3HNoJJFH1tGdZpqEXyCkrAxU.pYVm82NpjTWtW2RR
 iv6BDDl04oaA3dAXxVQPEy157ph4BW0VAA5ks1gB3iaBy8AUljPxfQtdLgBedDsUncP3i46RzJRw
 cLspoZlxCrGNUeyWpAYt.VGAsS7LTtw7AzdK_YaNeMVNAd3Y6xdW19.WDam7DZWP8fopH_cimYN_
 SkzyUrezakpgLsm_HJrvzz0ctY73UkDu6rW9HA8xv8BUsjFGdd81vpGOjhZjF.2Dk0K8EYCF9qHZ
 8qrnjeCRBYlIjPdigW6p5.iDzS9YBaLqSUHzXoAHkUf3a.zFmnLGNKUxvxV.Vhh1lB2pQHb2tZhl
 wXxk3BIsT85NuhAgcsizMqFjBQ83EC_iaaiW7PDfgCmoLpOm9aN90gUaMf6fB8KVnMRt2jNhMSiL
 Xt4zHTX8khF2O7wLc0FoFRY9QBlaigck247i38mGVpNvrtSfxH9uwPI3BQ5uERST8iyugh5Qt.SA
 rJZvIVH7Du8ATNrZc.D9EhaUEk3zP2h3P6Iiw3YUFA87votbMn10SZGYro5EZEyWdvCwocjuYdH.
 p9YNgFhCLtYPF1q854Ki2IYuY39mj2hK3FVSTJiGqBKBmgopME5tWsIrfo82tANfjiplV_B4TyA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 2 Jul 2020 10:25:56 +0000
Date: Thu, 2 Jul 2020 10:25:55 +0000 (UTC)
From: Marilis Mannik <mariliis.manniik@gmail.com>
Message-ID: <75899469.149457.1593685555996@mail.yahoo.com>
Subject: Urgent From Hospital
MIME-Version: 1.0
References: <75899469.149457.1593685555996.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
Message-ID-Hash: E2L4LTOUARXEYFBIGM35562BPXLVWSIF
X-Message-ID-Hash: E2L4LTOUARXEYFBIGM35562BPXLVWSIF
X-MailFrom: mariliis.manniik@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: manniik.mariliis@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E2L4LTOUARXEYFBIGM35562BPXLVWSIF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Hello My Beloved
this is Ms Marilis Mannik from Estonia writing from the hospital here in Ivory Coast;Dear I want you to know that I'm dying here in this hospital right now which i don't know if i will see some few days to come.

My Beloved, i was informed by my doctor that i got poisoned and it affected my liver and i can only live for some days. The reason why i contacted you today is because i know that my step mother wanted to kill me and take my inheritance from my late Father. I have a little adopted child named Andrew C. Mannik that i adopted in this Country when my late Father was alive and $3.5 million Dollars i inherited from my late father. My step mother and her children they are after Andrew right now because they found out that Andrew was aware of the poison, and because i handed the documents of the fund over to him the day my step Mother poisoned my food, for that reason they do not want Andrew to expose them, so they are doing everything possible to kill him.

My Beloved, please i want you to help him out of this country with the money, he is the only one taking good care of me here in this hospital right now and even this email you are reading now he is the one helping me out. I want you to get back to me so that he will give you the documents of the fund and he will direct you to a well known lawyer that i have appointed, the lawyer will assist you to change the documents of the fund to your name to enable the bank transfer the money to you..

This is the favor i need when you have gotten the fund:

(1) Keep 30% of the money for Andrew until he finish his studies to become a man as he has been there for me as my lovely Son and i promised to support him in life to become a medical Doctor because he always desire for it with the scholarship he had won so far. I want you to take him along with you to your country and establish him as your son.

(2) Give 20% of the money to handicap people and charity organization. The remaining 50% should be yours for your help to Andrew.

Note; This should be a code between you and my son Andrew in this transaction "Hospital" any mail from him, the Lawyer he will direct you to, without this code "Hospital" is not from the Andrew, the Lawyer or myself as i don't know what will happen to me in the next few hours.

Finally, write me back so that Andrew will send you his pictures to be sure of whom you are dealing with. Andrew is 14years now, therefore guide him. And if i don't hear from you i will look for another person or any organization.

May Almighty God bless you and use you to accomplish my wish. Pray for me always.
Ms Marilis Mannik
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
