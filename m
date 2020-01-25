Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3212014A206
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Jan 2020 11:33:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6C91210096C93;
	Mon, 27 Jan 2020 02:36:53 -0800 (PST)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=192.254.163.56; helo=rot.rotovacstart.com; envelope-from=godwinemefiele1221@yahoo.com; receiver=<UNKNOWN> 
Received: from rot.rotovacstart.com (unknown [192.254.163.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ABDF510097DD7
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jan 2020 02:36:51 -0800 (PST)
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
X-No-Auth: unauthenticated sender
Received: from Shop01 (localhost.localdomain [127.0.0.1])
	by rot.rotovacstart.com (Postfix) with SMTP id 9A81F5B953DE;
	Fri, 24 Jan 2020 14:09:36 -0600 (CST)
Received: from [47.227.221.113]
	by Shop01 SMTP id 2dm6Bz2DemqiIW;
	Sat, 25 Jan 2020 01:11:40 +0500
Message-ID: <033b$78-2r-c$162zv@m1abwvm.6.6zi>
From: "Godwin Emefiele" <godwinemefiele1221@yahoo.com>
To: open-iscsi@googlegroups.com
Subject: HOW ARE YOU DOING TODAY
Date: Sat, 25 Jan 20 01:11:40 GMT
X-Mailer: AOL 7.0 for Windows US sub 118
MIME-Version: 1.0
X-Priority: 3
X-MSMail-Priority: Normal
Message-ID-Hash: 3MXQEIAXQHGZZ3CYB3VWSBOVAAOIKEHU
X-Message-ID-Hash: 3MXQEIAXQHGZZ3CYB3VWSBOVAAOIKEHU
X-MailFrom: godwinemefiele1221@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Godwin Emefiele <godwinemefiele1221@yahoo.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3MXQEIAXQHGZZ3CYB3VWSBOVAAOIKEHU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain;; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Friend.


I am Mr. Godwin Emefiele, the current executive governor of the Central Bank of Nigeria
(CBN).

I am please to inform you that an unpaid contract payment file worth Seventy Seven Million Five Hundred Thousand United States Dollars ($77.500.000.00) only was recently discovered during the auditing exercise at the closure of  the fiscal year of 2018.

With my position as the Central Bank Governor it was easy for me to move the funds to a secure bank account in Europe which will be disclosed to you upon your confirmation of your interest on the transaction as my foreign partner.

The transaction, will be a bank to bank wire transfer to any nominated bank account of your choice.

Kindly supply me with your details  as listed below as to enable me prepare the documents require for the transaction on your name for immediate release of the funds via the Europe bank to any nominated bank account of your choice.


Your Formal Name
Your Direct Contact Address
Your Bank Name & Address
Account Number,
Routing Number,
Swift Code
Your Private Telephone Numbers.
Form of Identification

I will personally furnish you with steps assigned for this payment inline
with the European banking system.

As to know whom you are dealing with, view the website below for verification.

Website cenbank.org

https://www.cbn.gov.ng/AboutCBN/Thelist.asp


Sincerely
Mr. Godwin Emefiele.
Excutive Governor Central Bank (CBN).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
