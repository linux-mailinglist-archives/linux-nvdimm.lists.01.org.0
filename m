Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 222FE327CBD
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Mar 2021 12:01:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 51868100EBB6B;
	Mon,  1 Mar 2021 03:01:33 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=216.117.144.139; helo=mail.aymbus.com; envelope-from=aahfoffice@gmail.com; receiver=<UNKNOWN> 
Received: from mail.aymbus.com (unknown [216.117.144.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83899100EBB6A;
	Mon,  1 Mar 2021 03:01:29 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.4.3 (2019-12-06) on aymbuscom
X-Spam-Flag: YES
X-Spam-Level: **********************************
X-Spam-Status: Yes, score=34.7 required=7.0 tests=ADVANCE_FEE_5_NEW,
	AXB_XMAILER_MIMEOLE_OL_024C2,BAYES_99,BAYES_999,DOS_OE_TO_MX,
	FORGED_GMAIL_RCVD,FORGED_MUA_OUTLOOK,FREEMAIL_FROM,FREEMAIL_REPLYTO,
	FREEMAIL_REPLYTO_END_DIGIT,FROM_MISSPACED,FROM_MISSP_FREEMAIL,
	FROM_MISSP_MSFT,FROM_MISSP_REPLYTO,FROM_MISSP_USER,FROM_MISSP_XPRIO,
	FSL_CTYPE_WIN1251,FSL_HELO_NON_FQDN_1,FSL_NEW_HELO_USER,HELO_NO_DOMAIN,
	MALFORMED_FREEMAIL,MIMEOLE_DIRECT_TO_MX,MISSING_HEADERS,
	NSL_RCVD_FROM_USER,RDNS_NONE,REPLYTO_WITHOUT_TO_CC,SPOOFED_FREEMAIL,
	SPOOFED_FREEMAIL_NO_RDNS,SPOOFED_FREEM_REPTO,TO_NO_BRKTS_FROM_MSSP,
	TO_NO_BRKTS_MSFT,XPRIO autolearn=no autolearn_force=no version=3.4.3
X-Spam-Report: 
	*  3.8 BAYES_99 BODY: Bayes spam probability is 99 to 100%
	*      [score: 1.0000]
	*  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
	*      [score: 1.0000]
	*  0.0 NSL_RCVD_FROM_USER Received from User
	*  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
	*  1.8 FSL_HELO_NON_FQDN_1 No description available.
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
	*      provider
	*      [aahfoffice[at]gmail.com]
	*  1.2 MISSING_HEADERS Missing To: header
	*  1.0 FORGED_GMAIL_RCVD 'From' gmail.com does not match 'Received'
	*      headers
	*  0.3 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
	*      digit
	*      [aahf1971[at]gmail.com]
	*  0.9 FSL_NEW_HELO_USER Spam's using Helo and User
	*  3.1 MALFORMED_FREEMAIL Bad headers on message from free email
	*      service
	*  0.0 FROM_MISSP_XPRIO Misspaced FROM + X-Priority
	*  0.0 FROM_MISSP_MSFT From misspaced + supposed Microsoft tool
	*  1.2 RDNS_NONE Delivered to internal network by a host with no rDNS
	*  0.0 HELO_NO_DOMAIN Relay reports its domain incorrectly
	*  0.0 FROM_MISSP_USER From misspaced, from "User"
	*  0.6 REPLYTO_WITHOUT_TO_CC No description available.
	*  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
	*  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
	*      different freemails
	*  0.0 FROM_MISSP_REPLYTO From misspaced, has Reply-To
	*  2.5 TO_NO_BRKTS_FROM_MSSP Multiple header formatting problems
	*  0.0 FROM_MISSPACED From: missing whitespace
	*  2.0 MIMEOLE_DIRECT_TO_MX MIMEOLE + direct-to-MX
	*  1.5 SPOOFED_FREEMAIL_NO_RDNS From SPOOFED_FREEMAIL and no rDNS
	*  2.3 DOS_OE_TO_MX Delivered direct to MX with OE headers
	*  0.0 SPOOFED_FREEMAIL No description available.
	*  2.5 TO_NO_BRKTS_MSFT To: lacks brackets and supposed Microsoft tool
	*  2.2 XPRIO Has X-Priority header
	*  0.0 SPOOFED_FREEM_REPTO Forged freemail sender with freemail
	*      reply-to
	*  2.5 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
	*  3.1 FROM_MISSP_FREEMAIL From misspaced + freemail provider
	*  1.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
	*      419)
Received: from User ([185.215.151.154]) by aymbus.com with
 MailEnable ESMTP; Fri, 26 Feb 2021 17:51:50 -0800
From: "AAHF"<aahfoffice@gmail.com>
Subject: ***SPAM*** Dear Supporter
Date: Fri, 26 Feb 2021 17:51:40 -0800
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <5FFF0D3B282F48369BAECDE2324F970D.MAI@aymbus.com>
X-Spam-Prev-Subject: Dear Supporter
Message-ID-Hash: HOMFTX4D5EJJEXT47RDOVJG2W75QWHYC
X-Message-ID-Hash: HOMFTX4D5EJJEXT47RDOVJG2W75QWHYC
X-MailFrom: aahfoffice@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: aahf1971@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HOMFTX4D5EJJEXT47RDOVJG2W75QWHYC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Supporter

RE: LETTER OF INTRODUCTION AND REQUEST FOR PARTNERSHIP/SUPPORT-THE COMPLETE STRUGGLE TO BRING HAPPINESS TO THE ORPHANS, LESS PRIVILEGED AND THE HELPLESS OLDER PEOPLE.

We are happily contacting you for this course because you are a kind-heartily fellow and a promoter of the welfare of the less privileged, here may not your focus site for charity or you may not have an interest in such as an individual, but I beg of you, rethink, we are all human-being and the people of this part of the world totally need your partnership/support.

The Asadu Amagu Humanitarian Foundation (AAHF) is a registered NGO and all government authorize operational approval documents are available for your perusal and/or verification, we start in early 2018 and our aim and objectives are to promote the well-being of the helpless/sick older people and for Godly upbringing of orphan children, less privileged and to fight against internet scammer and fraudsters and crimes in Sub-Saharan African and the world since our search proved beyond a reasonable doubt that bad government policies and abuses of public offices born crime around Africa.

Your partnership/support with AAHF stands a chance to save souls and make our world a better place for an inhabitant, AAHF, is not against any region/s we are against immoralities and crime. To make our world crime free, please party with AAHF. I assure you no advice, mainstream or financial support you give to AAHF will not be misused, your partnership with AAHF is needed and we will be accountable to you.

An adage says! In every twelve (12) there must be Judas Iscariot, that betrayed Jesus and in every thirteen (13) there must be Jesus Christ the savior of the world, please do not think everybody in Nigeria, West Africa is bad, many are good people, but unfortunately bad people are more because of hardship, please work with us to give the downtrodden a better life and save souls. The entire management of (AAHF)  Asadu Amagu Humanitarian humbly asks now for your personal donation support, we appreciate any amount, we need money for human empowerment and to buy medicine, food items and clothes, etc., to put a smile on the face of the Orphans and unprivileged and the helpless sick older people.

Please upon your willingness for freewill donation, kindly contact us banking detail:

Yours faithfully,
Miss. Ogechukwu Agashi
Public Record, Officer,
ASADU AMAGU HUMANITARIAN FOUNDATION (AAHF)
Direct Telephone: (+234) 7036585426    
E-mail:  info@aahfoundation.com.
ngwebsite: https://aahfoundation.com.ng
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
