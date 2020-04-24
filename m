Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F5F1B7CCA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Apr 2020 19:30:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43272100DCB73;
	Fri, 24 Apr 2020 10:29:52 -0700 (PDT)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=74.6.134.41; helo=sonic307-2.consmr.mail.bf2.yahoo.com; envelope-from=inf.org28@hotmail.com; receiver=<UNKNOWN> 
Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C6A7100DCB71
	for <linux-nvdimm@lists.01.org>; Fri, 24 Apr 2020 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587749420; bh=7ELyVF1TY+atgcMFgVn9M9BygqHRBcTANas5h4WBA6Y=; h=Date:From:Reply-To:Subject:References:From:Subject; b=iW4c6CHTPBi3+4Q69Y/FeOakrIIsf6rrqlAiVkFNjRHAN9FlkxIilYu2Y5elSDy60yOPZ/8PQ+jpv7m1C4z08BYjZvI/DN+YXG1k9KZMBtLcdgnqHj7/7gvcSkI5UjxOzhoZ3J/fGoAiELhzy7JJBK5tmLMguN0eHLGK6Kp8SOGpy8lVE29Za+/mlZ5q36fTuk8W6q8liF3M6wTqV6L0ZquuIO3dM3vUPUkrrR/+xu7BMl3YECFbk49RJR5LKtfknVHvsv3TudQ3V6U5cC2p9tPPgqwx0GDsySQ2lAco1LXkD8zx0BV4ld4K9+g8qzoEOm5qwfC82MHJHIvgWy/exg==
X-YMail-OSG: DrP7LFoVM1kRydTGk1fHZg_1xO_tx5IqwOK3ZpOnl28HlTS65lOElscnDdtnH8L
 MK823Cz6h4PXtP3.YB7QG.bssn0MugNBpcmFJKYADAcwUKgppes7h3nsR5SdC7qjakyiH2hgjwMK
 TIWPAZ4QphQhXqcFtvpNBaFeKPMvwEpsoE00rPPJsoOB4JSCx6XtCg8QvASqguBkTNMWY5JUy9_4
 M1pFD3vrOm4_rg4Ghn4u7XI9qVihx8PSMvrN1cbDJ64.XqK98mSuKKDBidmXjSXjtagLL6TSu2lq
 OXMHUpbR7uerL40AdF2ild3alEWmHl_KD6H781LZeVwr25xrD.CRVN9wnD7Zg.in7mXhBFZAqbJv
 xoPNgSQs2wTgozf8dWIMe1QXkHdIDGhsjKsK4Z3kRgBU_Y5cLJ3lOqtXA3DuOIJkVuUdBVXRvdCi
 F1rJRMOVfY1kJ2z8TlnM3QFg8A9MPenJLdkidnD.2.pG7EUzMS8hlQOiV.0pD8zWGQJfGG7806RM
 UF_lPhDnXeX5nHzfdHaneg6JE2c3StgtMJd6aW8.PdxqXRmIReFHJ9KES.cG4jZLpo18qeROfQup
 YosQBUpallABTRmvUyoUa.zN00hbbMilGBCHyZJ2NfdBLdQCs7Ss0lNSMTu4pM4PosjXxTL0kiBD
 qgBNmIcRky1OUH4Wfkf83ASDoTUJf74pUYJMR1K.9YFHYZnBWxmCzOzrPSrYjbugTWoOyQnlhadH
 7V6esh0QcUxFZGgcJ6hNMXHzV3K55v1XBRaXGc24y55Sp0D6G1xbApCyIOCvn9P5cLEMXFojfMMK
 DQFLFfFpIxMAMZJYsWOiDsad7XDez3gpOWuR9jAKGau.Jh_lydk9cTuLzKXX79DdYAC4U3C766SB
 .5dicQIZGCgxxZObGJcl0GIJWwH6xXMy9EDww3fvjyPa79OfrZvOIHaHhKPdZcx7ELDmInVMuwDy
 EsP_nZse9t9D6lU6hrBwSxbpADE6ZAUGdzRjCeB8ppnLpS9zeXaH26ej010OPYYSLuD3EYVsho7o
 ytrDLJnVOVrLZ_sJaoql0EKnWEMPSXyrojhAXGBpML5SSw6dM54q2UEcQoeBgKxYS8X4I3_tRc1Q
 44z2OQQ.SSiWD8.FigsG7zIXB7lF_RIH44aID6_5ZoT5JGvRcF3nDB9uNS_r6VL7uhv0LpqbI1M.
 kyWmwPrRJHYnDSWLMclhHq_3QNiugds5Bk5Zi8m54TDtFm6etxXeqJpVcbNpz4e2zgCEKuP2IUuy
 wAma6yyzBJyPL5PxivhyW0.TbABIxhQ5baDMgOHqHs152Zou.vvMwbBCxpFwJAlx4Rch8iYqEuV.
 .JVXFUPo8UypQLjQufzV3GDe6Plcn6d2V
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Apr 2020 17:30:20 +0000
Date: Fri, 24 Apr 2020 17:30:19 +0000 (UTC)
From: Keffier Robert <inf.org28@hotmail.com>
Message-ID: <1091359667.210425.1587749419068@mail.yahoo.com>
Subject: ATM Card Delivery.
MIME-Version: 1.0
References: <1091359667.210425.1587749419068.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15776 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20100101 Firefox/11.0 CometBird/11.0
Message-ID-Hash: 5CXGVMVSP3G7CUMEBH5KX2V3YU2F3ZK6
X-Message-ID-Hash: 5CXGVMVSP3G7CUMEBH5KX2V3YU2F3ZK6
X-MailFrom: inf.org28@hotmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: dhlcompany71@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5CXGVMVSP3G7CUMEBH5KX2V3YU2F3ZK6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Good day,

I wish to inform you that your overdue payment worth of $1.8M USD has be scheduled to pay you through certified ATM Card which you will be only required to proceed to any ATM Cash Point to withdraw $5,000, 2-times per day till your fund is completed.

Meanwhile, the valid ATM CARD was registered with DHL Courier Company as a packaged. All you need to do now is to contact them on their information below with your delivery address for the immediate delivery to your giving address without any delay.

Manager Name: Mr. Gary Waddell Jr.
E-mail: dhlcompany71@gmail.com
Phone/Fax: (+234) 808 417 322.

Thanks,
Mrs. Keffier Robert
"IMF" Fund Delivery"
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
