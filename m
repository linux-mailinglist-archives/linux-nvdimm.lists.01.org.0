Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1801C3911
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 May 2020 14:15:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D862611504ED1;
	Mon,  4 May 2020 05:13:25 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=74.6.134.40; helo=sonic307-1.consmr.mail.bf2.yahoo.com; envelope-from=elodieantoine5777@gmail.com; receiver=<UNKNOWN> 
Received: from sonic307-1.consmr.mail.bf2.yahoo.com (sonic307-1.consmr.mail.bf2.yahoo.com [74.6.134.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27AC211504ED0
	for <linux-nvdimm@lists.01.org>; Mon,  4 May 2020 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588594497; bh=r5QHRsE0gRLjHV/jve/1QelQ13auG1gTnnP/vIL2AZM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=T7FFS2vrdy4IYBJ871sJccr7j0GHWVNyLo2+YuuJD+6Q4i/NWfj9PC9Qv6IQCnC+aHefR/7ODUQhu7SsrdMVXKCQ/bZveU6EguqIT5lssUUfV/dueB/YKoFN1mfdfLB84NvO0YIfEAsmc+FDMAeZfX3d7OgPxtEhLN7C8JVKsC3R/c8HxUixaTxEpv7yMlGEliw4j+yap54E08csFG2zmC1lVcTPPkj6PbYhcldzP+QDKj+6nqaZKz+AUfnOKKjXKU05QZrpHgKd364cP2OwFdc+IcnPuntQ9kAyTrMzD1wrXH6e04+A6yRDHtoMPB1Z+M0TemLgrATLM5enxmRxfA==
X-YMail-OSG: 4RvDgWsVM1miFlFpk7JWWCp5UhL76TlzsdooI_kpTi8PhzjImCN3YT0_S6uT2CU
 7UHJjkeKROYXLgPZ82eECFwA7HyFGoB3NjHWG_fCNcWxuz3ChLEQNjg5BwoDgQUFHlI9MqRpGixl
 yof1ZtXrYkMX8Zug4LR7GGYAz8D30AmekYvhjJDcMduP.zj_h9Cu8GIgz7shOKTFfrvvxW5gTcxY
 1dnxHM71.Ciro.gF9_PsD2jZRPQzziIb6BJIybFV8LJ_DxKR5hJlj7nr8UG567tT6Ued4FS6Pftd
 huNzmYszSCdbGBeY0uE3iUWojmCddpjcrB6e4jdDkHWwaYZ3uvBhEpQn.4fb3JHmT0lwfcko72PV
 NPM.AGI44eMg0HmyegKLR6.F8Wit17UjlbpYIsxlGLszgg67BVygDvDOG3AZMjBEyaegCzzEWNiT
 iCEcZWu1_8SWuQmIZ400kdZ6ykPR2itKs7DPTGBP2kFjD38NnuU4pU7gFU2LSNMhhMO.cN3Vindr
 E0oexg5lwiP9J6ftoqN2j6m4Yj6MAECMEr00ZWfKMUkjbLvDqW84LZL1DaW9D7zxG.DGiogKwSfD
 yJOm85A_B42T94tF.dx8SJZL_3TqqIp8ipLPI3KsZjF8yKEWoColTCkvv8UEiZnuXcIaTyQh7qPx
 qyeDLIwXcm6_fHGbVh8XsZOMD1pL7RChQqWWCP.Y_vWpQbuB3kYLCh1RW0nuKGULS6pjggNQHQ0e
 XxmZHAqP_pFBSzkqIm3e9ekzrRrLh.5cGu.1BpJZ9eIkStzaymrgN_XNUQ.O486qWQp23yxhHtUF
 wPLAfkozEDFY7ZK.d8rgF_6NqK6r06ggUhAuUy_quLcBelDUeZvl7_QiOPE5VAc8XbhUq1SgeQ.8
 eU5H84f4ezlM9xgdtvTHsKpEIM5ZoxL1MJEi7XLheXQV7dp8ybwGTD1ycjm2yDZwylpOgbqFJF2M
 PvkAv_ipHp.yFvCYM7QGj_EOiPaOsLiQ31Ve02txAjeDtabUYQrrW.49RTNVTeUAErr92sBgGeJF
 Do_IqhaKfYm.JHFtdWKMqC0jdUdmKWUdN624SCGLWxxY6V_ghHqtSgMN1Jg_qxWFS5Y9dkUFB.SZ
 ADr5LPg692bD7EvKBq.gMBr6nWV95FeyiP9dRlWhqZst4Ahu98byCeOXg9J2J0fespORu3tQylmr
 oTwD11KWqyR3aPcwQLG8Ebh6eHnwJc6dtqmX5XpHFlEvc4PdybaSwrzqpeHEqNVZa4iV8jNSvSIM
 GzKNlXAkBlC8PnYEwQCEKoz15qZrtgz9rdjNDRPJp4LJsuAOmYBXMqZ5TG33j6ApqQH5sBIMHDg-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Mon, 4 May 2020 12:14:57 +0000
Date: Mon, 4 May 2020 12:14:53 +0000 (UTC)
From: "Mr.Antoin Mark" <elodieantoine5777@gmail.com>
Message-ID: <581096038.555065.1588594493029@mail.yahoo.com>
Subject: Greetings!
MIME-Version: 1.0
References: <581096038.555065.1588594493029.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:75.0) Gecko/20100101 Firefox/75.0
Message-ID-Hash: KGE4GNACUTUCEJMB5GTCSV7FURBD4YN5
X-Message-ID-Hash: KGE4GNACUTUCEJMB5GTCSV7FURBD4YN5
X-MailFrom: elodieantoine5777@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: antoinmark17945@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KGE4GNACUTUCEJMB5GTCSV7FURBD4YN5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Dear Friend,

 Greetings!

How are you with your family today? I hope both of you are in good
health. Decently I know that this message might meet you in utmost
surprise as we never know each other before. I am Mr.Antoin Mark, a
banker by profession, I need your urgent assist in transferring the
sum of $6.2 Million U.S Dollars into your account. It is 100% risk
free and under this achievement you are entitled to receive 40% of the
total cash. More details will be sent to you on confirmation of your
interest.

Regards;
Mr.Antoin Mark
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
