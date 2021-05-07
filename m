Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADA376B99
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 23:23:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C658100EAB77;
	Fri,  7 May 2021 14:23:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.96.187.8; helo=bosmailout08.eigbox.net; envelope-from=srs0=pgjcw1=kc=godsofu4.com=fast65@eigbox.net; receiver=<UNKNOWN> 
Received: from bosmailout08.eigbox.net (bosmailout08.eigbox.net [66.96.187.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 730E5100EC1C6;
	Fri,  7 May 2021 14:23:13 -0700 (PDT)
Received: from bosmailscan08.eigbox.net ([10.20.15.8])
	by bosmailout08.eigbox.net with esmtp (Exim)
	id 1lf7wG-0000nC-4T; Fri, 07 May 2021 17:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=godsofu4.com; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
	Message-ID:Reply-To:Subject:To:From:Date:MIME-Version:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aM9bUFGSTpfnep8zAVAJMnojqhcwpuHDFPgQnPqW4M4=; b=D9xc9z2XXQ6za733pn6zNwVHh2
	yi/G3hmez+DkcmKrXkutqwqOvbPlQzvG5daYtocRyE7ErYtSckhTq1q0oozH8EZtya2BgUqhmhHBQ
	ipD8+NvQRm3yZb9IaYBqsuhxJ6bjSEeAfqOr3hyRX4g1/mEPuSKH5nRR+yyPtq/oMecVMCrVLhodX
	NtWVGZKpShnmQ3312xsju/CSruZUDAlP6Lwb8vS5OL5VdVs6pKVRhTrNZxmco2dN71NjTD8/k40c4
	mzpDwnf6GNIZhFG2H89c7TgS8owkK3nwm97ljNy7tiLP2qjoxfINpHTAskCX/k7tDN5C59RvavPPM
	GbQfejuw==;
Received: from [10.115.3.33] (helo=bosimpout13)
	by bosmailscan08.eigbox.net with esmtp (Exim)
	id 1lf7wD-00012U-Qt; Fri, 07 May 2021 17:23:09 -0400
Received: from boswebmail06.eigbox.net ([10.20.16.6])
	by bosimpout13 with
	id 1xP12501v07qujN01xP5rD; Fri, 07 May 2021 17:23:09 -0400
X-EN-SP-DIR: OUT
X-EN-SP-SQ: 1
Received: from [127.0.0.1] (helo=homestead)
	by boswebmail06.eigbox.net with esmtp (Exim)
	id 1lf7vo-0004yK-Ux; Fri, 07 May 2021 17:22:44 -0400
Received: from [197.239.81.229]
 by emailmg.homestead.com
 with HTTP (HTTP/1.1 POST); Fri, 07 May 2021 17:22:44 -0400
MIME-Version: 1.0
Date: Fri, 07 May 2021 21:22:44 +0000
From: Mrs Suzara Maling Wan <fast65@godsofu4.com>
To: undisclosed-recipients:;
Subject: URGENT REPLY NEEDED
Mail-Reply-To: suzara2017malingwan@gmail.com
Message-ID: <919a41d8bdaaf0075d1fa928f2ce17b3@godsofu4.com>
X-Sender: fast65@godsofu4.com
User-Agent: Roundcube Webmail/1.3.14
X-EN-AuthUser: fast65@godsofu4.com
Sender: Mrs Suzara Maling Wan <fast65@godsofu4.com>
Message-ID-Hash: P4TKCJGSAEOAWHBRKZHFZMZEYGLJJWIG
X-Message-ID-Hash: P4TKCJGSAEOAWHBRKZHFZMZEYGLJJWIG
X-MailFrom: SRS0=pgJCW1=KC=godsofu4.com=fast65@eigbox.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: suzara2017malingwan@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P4TKCJGSAEOAWHBRKZHFZMZEYGLJJWIG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



My names are Mrs Suzara Maling Wan, I am a Nationality of the Republic
of the Philippine presently base in West Africa B/F, dealing with
exportation of Gold, I was diagnose of blood Causal decease, and my
doctor have announce to me that I have few days to leave due to the
condition of my sickness.

I have a desire to build an orphanage home in your country of which i
cannot execute the project myself due to my present health condition,
I am willing to hand over the project under your care for you to help
me fulfill my dreams and desire of building an orphanage home in your
country.

Reply in you are will to help so that I can direct you to my bank for
the urgent transfer of the fund/money require for the project to your
account as I have already made the fund/money available.

With kind regards
Mrs Suzara Maling Wan
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
