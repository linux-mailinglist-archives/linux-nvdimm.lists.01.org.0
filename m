Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B36018CB25
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Mar 2020 11:06:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C888E10FC36EB;
	Fri, 20 Mar 2020 03:07:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=200.40.31.14; helo=mail.vera.com.uy; envelope-from=e445nau88@vera.com.uy; receiver=<UNKNOWN> 
Received: from mail.vera.com.uy (smtp-s05.vera.com.uy [200.40.31.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 250C510FC3639;
	Fri, 20 Mar 2020 03:07:09 -0700 (PDT)
Received: from avas06.in.vera.com.uy (avas06.in.vera.com.uy [172.24.32.34])
	by mta05.in.vera.com.uy (Postfix) with ESMTPS id 83CBA229517;
	Fri, 20 Mar 2020 07:06:14 -0300 (UYT)
Received: from mail.vera.com.uy (unknown [172.24.31.13])
	by avas06.in.vera.com.uy (Postfix) with ESMTPS;
	Fri, 20 Mar 2020 07:06:03 -0300 (-03)
Received: from mbox11.in.vera.com.uy (slbcorreolez-hsrp-reals.in.vera.com.uy [172.24.31.1])
	by mta04.in.vera.com.uy (Postfix) with ESMTP id 22B6C22107F;
	Fri, 20 Mar 2020 07:05:11 -0300 (UYT)
DKIM-Filter: OpenDKIM Filter v2.9.0 mta04.in.vera.com.uy B947C220CA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vera.com.uy;
	s=72E86E58-1335-11E4-BC8D-0ED04F92C007; t=1584698762;
	bh=YuZ4jZxbrYKoEFD9n+2ibCfDypdUV92cWHZQgFlF47c=;
	h=Date:From:Reply-To:To:Message-ID:Subject:MIME-Version:
	 Content-Type;
	b=gp3+1gbpJyAuiaY9YD+SFX8YySVMEHX+2p8GNsIFgkh8ZkCHAU6L+nz17/azdLxiI
	 b94arYWqqGs9kMsGlbNwJQszYvLENIoBl1NdmiwjrngLjYD51SYx4nBY5K5k63mTsk
	 URwKGPoUQYA+pWi8m2lE8WsuVN7nDr4kuygXB3rk=
Date: Fri, 20 Mar 2020 07:05:11 -0300 (UYT)
From: Express Loan South Africa <e445nau88@vera.com.uy>
To: advertoffice2020@gmail.com
Message-ID: <966322950.96539.1584698711076.JavaMail.zimbra@vera.com.uy>
In-Reply-To: <1230511989.37735.1584693730778.JavaMail.zimbra@vera.com.uy>
References: <543749942.2373807.1584433471067.JavaMail.zimbra@vera.com.uy> <297605209.2402675.1584439358294.JavaMail.zimbra@vera.com.uy> <1556290080.3274370.1584525641820.JavaMail.zimbra@vera.com.uy> <2018666152.3973505.1584586091632.JavaMail.zimbra@vera.com.uy> <80237296.4781626.1584675747051.JavaMail.zimbra@vera.com.uy> <180804016.619.1584687364045.JavaMail.zimbra@vera.com.uy> <1142722042.815.1584687450768.JavaMail.zimbra@vera.com.uy> <1230511989.37735.1584693730778.JavaMail.zimbra@vera.com.uy>
Subject: Loan Application Breakdown
MIME-Version: 1.0
X-Originating-IP: [172.24.31.31]
Thread-Topic: Are You In Need Of A Loan?
Thread-Index: exLdHmV3fCUPVxeYLYhOprGY2StXXKX04ZjmnlF+2hcHFHDRIsH6KYNgqLfpY4ZR/KmSm47ydwGVeF/n9NFWO31rPu0Q+bKQIU/Jok32Aq9iR7UQSUS5
Message-ID-Hash: KQ55ZJHYFVEBBKGQSJS3ASSUS2TM43CU
X-Message-ID-Hash: KQ55ZJHYFVEBBKGQSJS3ASSUS2TM43CU
X-MailFrom: e445nau88@vera.com.uy
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Express Loan South Africa <loansdepartment@aol.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KQ55ZJHYFVEBBKGQSJS3ASSUS2TM43CU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 
Good Day, 

 Kindly Find Attached Files And Send Your Documents Back To Us. Apply With Us On Our 5% Interest Rate, 

We Offer for all categories. Personal, Home, Debt Consolidation And Business Loans. Even thou you are blacklisted or under debt review. 

 We await your swift responds.

Regards, 

Mrs. Paula Rigt 

Office Line: +27 679 616 466 

Legal Registration No. : 2014/238085/07 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
