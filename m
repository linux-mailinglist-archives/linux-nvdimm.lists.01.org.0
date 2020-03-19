Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1B18AEF9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Mar 2020 10:14:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5A1E10FC3635;
	Thu, 19 Mar 2020 02:14:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=200.40.31.16; helo=mail.vera.com.uy; envelope-from=e445nau88@vera.com.uy; receiver=<UNKNOWN> 
Received: from mail.vera.com.uy (smtp-s07.vera.com.uy [200.40.31.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE1E210FC3630
	for <linux-nvdimm@lists.01.org>; Thu, 19 Mar 2020 02:14:45 -0700 (PDT)
Received: from avas05.in.vera.com.uy (avas05.in.vera.com.uy [172.24.32.33])
	by mta05.in.vera.com.uy (Postfix) with ESMTPS id 95A232293CF;
	Thu, 19 Mar 2020 06:13:52 -0300 (UYT)
Received: from mail.vera.com.uy (unknown [172.24.31.10])
	by avas05.in.vera.com.uy (Postfix) with ESMTPS;
	Thu, 19 Mar 2020 06:13:41 -0300 (-03)
Received: from mbox11.in.vera.com.uy (slbcorreolez-hsrp-reals.in.vera.com.uy [172.24.31.1])
	by mta01.in.vera.com.uy (Postfix) with ESMTP id AC3D6221D87;
	Thu, 19 Mar 2020 06:12:48 -0300 (UYT)
DKIM-Filter: OpenDKIM Filter v2.9.0 mta01.in.vera.com.uy 8BA44221DB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vera.com.uy;
	s=72E86E58-1335-11E4-BC8D-0ED04F92C007; t=1584609221;
	bh=bLG5/tkUAT5ucnDF1Z1ZUqQSCWMZlyfX94U2j1I7sVM=;
	h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:
	 Content-Type;
	b=hiqOKqFXnxck2RYEZ1ZeZ0GrqbeRo8Aj1uVG4Rg5WZX6CxQ8DFW0oD5BaT2ojznpH
	 NZFeIX9S0E19eqtnMbOGTS8ZUrKI9LNAFTf4sc+JYX9OdmfH4s32llxlUgmtwZfEuE
	 cIzaBEsZj8qdP284pjujwBNoUNEDix4nmEwyRlBY=
Date: Thu, 19 Mar 2020 06:12:48 -0300 (UYT)
From: Express Loan South Africa <e445nau88@vera.com.uy>
To: advertoffice2020@gmail.com
Message-ID: <250846317.4096961.1584609168619.JavaMail.zimbra@vera.com.uy>
In-Reply-To: <2018666152.3973505.1584586091632.JavaMail.zimbra@vera.com.uy>
References: <543749942.2373807.1584433471067.JavaMail.zimbra@vera.com.uy> <1797209059.2383907.1584436136979.JavaMail.zimbra@vera.com.uy> <955108038.2384677.1584436252488.JavaMail.zimbra@vera.com.uy> <316059032.2385317.1584436398522.JavaMail.zimbra@vera.com.uy> <1030837738.2399846.1584438890192.JavaMail.zimbra@vera.com.uy> <297605209.2402675.1584439358294.JavaMail.zimbra@vera.com.uy> <1556290080.3274370.1584525641820.JavaMail.zimbra@vera.com.uy> <2018666152.3973505.1584586091632.JavaMail.zimbra@vera.com.uy>
Subject: Loan Application Details
MIME-Version: 1.0
X-Originating-IP: [172.24.31.32]
Thread-Topic: Are You In Need Of A Loan?
Thread-Index: exLdHmV3fCUPVxeYLYhOprGY2StXXKX04ZjmnlF+2hcHFHDRIsH6KYNgqLfpY4ZR/KmSm47ydwGVeF/n9NFrs1mPrQ==
Message-ID-Hash: AMS6WQ52I5X3TNVX7UUZUBW7GBBQEWMU
X-Message-ID-Hash: AMS6WQ52I5X3TNVX7UUZUBW7GBBQEWMU
X-MailFrom: e445nau88@vera.com.uy
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Express Loan South Africa <expressloan@webmail.co.za>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AMS6WQ52I5X3TNVX7UUZUBW7GBBQEWMU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 
 
Attention, 

Kindly Find Attached Files And Send Your Documents Back To Us. Apply With Us On Our 5% Interest Rate, 

We Offer for all categories. Personal, Home, Debt Consolidation And Business Loans. Even thou you are blacklisted or under debt review. 

Legal Registration No. : 2014/238085/07 

Regards, 

Mrs. Paula Rigt 

Office Line: +27 679 616 466 

Emails: expressloan@webmail.co.za  And expressloan2020@outlook.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
