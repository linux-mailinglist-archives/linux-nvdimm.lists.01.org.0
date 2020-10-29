Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB4D29F218
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Oct 2020 17:49:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5EA7116535440;
	Thu, 29 Oct 2020 09:49:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::745; helo=mail-qk1-x745.google.com; envelope-from=3fpkaxxijdm80vw3z88z.ev1c9nlms17v36.x97638fi-8gy37763ded.lm.9c1@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x745.google.com (mail-qk1-x745.google.com [IPv6:2607:f8b0:4864:20::745])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 06FAC1651CDCF
	for <linux-nvdimm@lists.01.org>; Thu, 29 Oct 2020 09:49:03 -0700 (PDT)
Received: by mail-qk1-x745.google.com with SMTP id d124so2158416qke.4
        for <linux-nvdimm@lists.01.org>; Thu, 29 Oct 2020 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=h5nuN6UqmMB/sXH60ZjUngIZ5jKexaPAEGSB90KjT0c=;
        b=D904btzJIrvg/Opj7JCJ8zQSodJxJ1QfOD3WFLNtjqlhDXoBqhihJBYZOO8WdmnFdj
         5fPjjrGctQClVpJTaz5r3OGgLkmogTgaZO6MjfGjdE8JUQIfH+9xV8Eav09ioXOb1pgW
         XJ9CkLRtczGVgGizSnaPQPd8jVBEQxb0wlEIAi06cVg+wUZGD7vsLUth93Q63YpkA/oO
         XsLoxqMu+e3qC3laYuMRMobynj5BJYlIk95Oaf+cHIeuJ7aValfi/qCKuSvQgES9a333
         sD4YeT0BraLotmPtrH8olHBv+3PQ/f6e8DXCqq8AEG71iQxlh5sT3OwjQ9R4zoX2io5v
         kFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=h5nuN6UqmMB/sXH60ZjUngIZ5jKexaPAEGSB90KjT0c=;
        b=A8mW1XqQgiaiE2pVTeZE2DxdAgzWn2Bz933sTYACIoG8FQnGLEoNS7p8FX/N+j2AcT
         FBX/Lbi+SzEuaUwBuIdRbUHTkccDbxLGBJoWHUYOeYU9khfTvjEH6f57uJN11z84TuFD
         Qs1M/VfzI5FPZCQclz+VJf7uSSgRbvPUyE+kqSibSstse9Y56IM1x2i0Sl1czTwNrv2m
         kRYAlYZ7BUZS/KcX+i0qcY8BWPZUGE0FYdO9TT7BEH/ggacvmwIaFV9INRyqSYL0/pjP
         8hLMXaV8K1eTtdSNF8N0/nyfVxRIidmVuAVO7cfj3MNmOA1PRI2GDjsOi6f14PMFprsk
         Osaw==
X-Gm-Message-State: AOAM533JYGBIg57hDWX2/J7RELMxf9hxTHqE7J54twwtZK7WDnQxm6pN
	LFLKc3mt4krwQZaWQXV9esxJTCG2ttKaXbnX4vTC
MIME-Version: 1.0
X-Received: by 2002:ac8:6953:: with SMTP id n19mt4312370qtr.315.1603990140181;
 Thu, 29 Oct 2020 09:49:00 -0700 (PDT)
X-No-Auto-Attachment: 1
Message-ID: <000000000000876a0e05b2d20e4f@google.com>
Date: Thu, 29 Oct 2020 16:49:01 +0000
Subject: Could you help me in this transaction?
From: fabienne.tagro2017@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: ZKWUSRE7UUO5FR267W55VQ3OQDC6XNYN
X-Message-ID-Hash: ZKWUSRE7UUO5FR267W55VQ3OQDC6XNYN
X-MailFrom: 3fPKaXxIJDM80vw3z88z.Ev1C9NLMS17v36.x97638FI-8Gy37763DED.LM.9C1@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: fabienne.tagro2017@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZKWUSRE7UUO5FR267W55VQ3OQDC6XNYN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: 7bit

I've invited you to fill out the following form:
Untitled form

To fill it out, visit:
https://docs.google.com/forms/d/e/1FAIpQLSe1wBhXSQ5Skw4YywgnRWiOLeNuYO0dbmnMnsDvN4YAMDRi3A/viewform?vc=0&amp;c=0&amp;w=1&amp;flr=0&amp;usp=mail_form_link

Hello Dear,

I am very sorry that my letter may come as a surprise to you since we have  
never met each other before. I am Miss Nidal Aoussa. I am the only daughter  
of Cheikh Ag Aoussa, the President of (HCUA) in Mali who was assasinated on  
the octobre 2016.

https://www.jeuneafrique.com/365432/politique/mali-sait-on-mort-de-cheikh-ag-aoussa/
https://fr.wikipedia.org/wiki/Cheikh_Ag_Aoussa

I have a business transaction which i solicit your help. It is all about a  
fund to be transferred in your country for urgent investment on important  
projects. I want you to guide me and invest this money in your country.  
This fund amount to Eleven Millions Five Hundred Thousand United States  
dollars which i inherited from my late dad.. If you are capable of handling  
or participate in this transaction, kindly respond quickly through my  
private emails to enable me give you more details about this fund and how  
this project shall be carried out. I will accord you 20% of the total fund  
for your kind assistance. Respond through this my private emails addresses  
below.

Miss Nidal Aoussa
Email: ( nidal.kong1998@gmail.com )

Google Forms: Create and analyze surveys.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
