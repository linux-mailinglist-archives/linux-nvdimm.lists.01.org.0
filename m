Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F022641B1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 11:27:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B2C7141A4588;
	Thu, 10 Sep 2020 02:27:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.6.128.31; helo=sonic304-56.consmr.mail.bf2.yahoo.com; envelope-from=rosefranca198@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic304-56.consmr.mail.bf2.yahoo.com (sonic304-56.consmr.mail.bf2.yahoo.com [74.6.128.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E6ADE141A4586
	for <linux-nvdimm@lists.01.org>; Thu, 10 Sep 2020 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599730062; bh=GIslt9wQR8F4NESZCVXXpFf3iW5Q5Osnbck8IUhCqf4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dq23XFia4VQy2ZBVwat0QuOEBQBKT01vNAg6TdmvfFjGl4/u52bj4ZFntsp9W9VR7QSVmLk/NNYwqEDEX+N6wUzFqNLfKuGVsSh+raWoFy1fMP3ni9A4Pho+XDzwZTnut+Q1vhgmVz3KeUKprLWSYGTq8ApbUtFltXjwFUReMw+VHeu8NbYPSol8KU96k9BxB5YNJSx9G5T/Bz8QP2ohIs3v93C1vC2TIQiZ7DaN0bi4vgqkI6jqYa77vU8tdxQahnSI+zJAwibcVTNU+INVnB75U13HaFY16vBbl+NrO+AyRDl3g82/jbTlu6XGVoo77oVBc6vImIR/XzoTiuuQGg==
X-YMail-OSG: _A97oS8VM1lztjfhw1h3Glwtx0OI_CwrTcafUtl098emmtVSEJDA6172D_uCHXq
 pUfPlVKjlhtQX.cQIcJcq.DA5xSFBYhzGPR_Wt._.7Dhwt220iGVZNv9X31drPz4xMfP6TUxvITX
 Xr31gBQDruVl734lbRtnmWL9E9FEFCFjSa82xbbrmsiSeQdxrt8teklrqeZBmeXGoB_0EKYeRS03
 I7bdiIqb3KIgRgW0Xe5rLn85AvLwdLM4wXBlK4mpwXELEwxIrCPfzSmmf3Yk3dZr9kCOpbbk2CSi
 6i1rQQBcE6uuAtIJv_qgE_yPsvhRdsT1TcOPc74rs7D9nnWlEpPF2V1B9wjOQeUtigyIRlw9W6.5
 U_DDBoxV7dPEDfv.2NTMuRf9lExcBv.H7o8EwET4.Dzu7PW5sEZimAvBbByTrOJ_AyaY4W2M2wzo
 KgYgKiVMR.6SfJ3YBESFB9R5Ksm317pMFLaoYS7oiKiextdxAmotXlL2bop15Uka.3WvUnenFvvK
 gUAVu9AXdUKD78i.MKNlw0ON0LpHk10.TJ5JJlyC7Vf.pb6gxMnZSXg.ptWawyZfqI.i0w8iFnMx
 SLdYkVGmfb1UiNHvyVpvopC3GYQnPDT9M.P9N8GiCTsN6oMwqF3AGxQpgtMfs.IKYIrN3MXc0Mw8
 FfnZgCtfdXojiyM.Cc1..n5LQ_X6v28VltWQPxApLW_t6NulHulR7_ZIUYtGWSVVHwZDRH.JqHOR
 d5YigLsbRb2GRepT7v0AJdA0AfCFv9KnFVYKwiWtWgKW0PWV9JqSO.5H7vzGyFus15uUkx5_YgOR
 jWzGVdcRBh3jz4fKrK3394MfNU_A_Ur27qg1AiUFsuTl5PC.n_x2VCshAhRa0lS7hvzzQwWBKyHE
 LkALlAQ.rXbngdi6zAGQlnZwQ53JBON9mzOdBOvYhr5mM2Mt9wB2PwLfgylIrrD9d0Y.y92wp7Lh
 SsrPms.pn4CjW0N42q9OJAP7MjavD45U3CNeoePVf99NzIbIq6JAT8ipvzNoBgiUDgc..nf3J._E
 bCXcwP9myTjDseYD4AhP2_sPFgHIurWlwgyendwZ21.S7dhSKD5AumvocSxQY5nlaIhdUzAffOFs
 xhyGe5aR1j.FucMBYg55Xx0_FbADqcHMpnHSovXBS7hOa79CWlS8M2C_aVYs_yKsX8_o6cXbMUMU
 HTnBJ5X4JJhyy86ChWnxiC1XFXH7dNBEWDnnIeOL0cQBATcKjebafmuOv0v.OAh5qkM2xdfC.kFR
 4yofpOOpNQmIkIBkIVRJXtO_ZpZogjcNWMYSft_Vo9Yj6KwkI2lpZgMSiXs10ZhWX4s_IHkICJeE
 W1A1MDg.lLhz_QDiATYgnmIdz6Y3lg2CUqJBKu26YHjKKeMVRGDJzr_7rM_u6A8hkzOrD7Pg3v05
 qW4nUUuhFlA9iic.iX9JabA_eU.bzJgNbcyUpWg.BRX_gjflz.icg1Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 10 Sep 2020 09:27:42 +0000
Date: Thu, 10 Sep 2020 09:27:41 +0000 (UTC)
From: Franca Rose <rosefranca198@yahoo.com>
Message-ID: <75850349.596797.1599730061421@mail.yahoo.com>
Subject: Hi,
MIME-Version: 1.0
References: <75850349.596797.1599730061421.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36
Message-ID-Hash: QIEMW5JEOJDHD3MU2PPABPE4LTHU25TB
X-Message-ID-Hash: QIEMW5JEOJDHD3MU2PPABPE4LTHU25TB
X-MailFrom: rosefranca198@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: rosefranca32@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QIEMW5JEOJDHD3MU2PPABPE4LTHU25TB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Hi,

i am trying to reach you hope this message get to
you.from franca

thanks,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
