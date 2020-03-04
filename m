Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32625179AE6
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 22:27:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E161010FC36ED;
	Wed,  4 Mar 2020 13:28:39 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=182.50.132.193; helo=sg2nlshrout01.shr.prod.sin2.secureserver.net; envelope-from=maria.parker@bizcampaigns.com; receiver=<UNKNOWN> 
Received: from sg2nlshrout01.shr.prod.sin2.secureserver.net (sg2nlshrout01.shr.prod.sin2.secureserver.net [182.50.132.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4B3D10FC36EC
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 13:28:37 -0800 (PST)
Received: from sg2plcpnl0058.prod.sin2.secureserver.net ([182.50.151.6])
	by : HOSTING RELAY : with ESMTP
	id 9bXOjcgCZ9Rit9bXOjZof2; Wed, 04 Mar 2020 14:26:42 -0700
X-CMAE-Analysis: v=2.3 cv=ELR4LGRC c=1 sm=1 tr=0
 a=B5q7Ws3u1B736MAc2v8hUw==:117 a=oFlXQaNikBCUBGGIaLj5Mw==:17
 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=SS2py6AdgQ4A:10 a=DAwyPP_o2Byb1YXLmDAA:9 a=-LQFXck5qFl655GfGBMA:9
 a=SwfNpXSZ_-EUDAuO:21 a=UHC_9RG365zk5VKY:21 a=CjuIK1q_8ugA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=iM15-LIMPx_mPzY9v_YA:9
 a=f2E1jHpyof8WYNty:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-SECURESERVER-ACCT: maria.parker@bizcampaigns.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bizcampaigns.com; s=default; h=Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G2Uu+UbNYz3JJKWZrgIGJCE2W6f9b48BPMyNXYIeUUA=; b=eOlG4Fe16w0FfeUBGQ/hGeuxcy
	1qzY+wFyLjCdO6DYnxj72XEhpr6sRZbpJZTun1tFMNwiuoczmurhBPKl1ae5Dd1NgPKY7mWnAer9I
	v8as6Oisr7o/3vh1iBeljqaBNtGjwK3+G0vVRQroVW+y4IACQY1TkUuqOvbRn1TeBa9WSS9FgZYCb
	z14lhpygS8SqBTCipX18q8TdSOv8VOC5pqFFhbTRqJ/H4JJ7HbnE6gX3HoOJLQJkHd7bNL5+BizT8
	Wgb5FL6+TdC7yGmJ7/GrDjq3Vpp4raRVID9Z3e9zm7KpleHBJujsRwOJg9Xt2z/bBkN8nahNCp3jO
	r7ngymTA==;
Received: from [159.100.24.170] (port=57573 helo=WS63)
	by sg2plcpnl0058.prod.sin2.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.92)
	(envelope-from <maria.parker@bizcampaigns.com>)
	id 1j9bXN-002781-8G
	for linux-nvdimm@lists.01.org; Wed, 04 Mar 2020 14:26:42 -0700
From: "Maria Parker" <maria.parker@bizcampaigns.com>
To: <linux-nvdimm@lists.01.org>
Subject: HR Software Users - Info
Date: Thu, 5 Mar 2020 02:56:38 +0530
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAACVKgD6zjqpIlAH7GNVVyrPCgAAAEAAAAPhT5l4B0cpBgNlPBh9j5cUBAAAAAA==@bizcampaigns.com>
MIME-Version: 1.0
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdXya5NApvPoZe4jRnm/OsbDar7Phg==
Content-Language: en-us
Importance: High
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sg2plcpnl0058.prod.sin2.secureserver.net
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bizcampaigns.com
X-Get-Message-Sender-Via: sg2plcpnl0058.prod.sin2.secureserver.net: authenticated_id: maria.parker@bizcampaigns.com
X-Authenticated-Sender: sg2plcpnl0058.prod.sin2.secureserver.net: maria.parker@bizcampaigns.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfHk64wmg2XL+wv7H0hoPcE7eKtR8sOjSLdvSQ1VSeHUgivAiq/hQBN52NZqDASSwFrVeKmnyK2T4R7QlE4JBCOoR0odqUssmIgNOwMQhUtjLE0MBm6OY
 rdVSqFmLVEhSJjswFgZsGmUNbEvVVjdmjnG1NvoFECPcSZoedgIh907lI7QY0JPMZEmsGEbPAo0sjFBjeUb/iOR170a0GS/de8LYn8xK/XlJYrz75n7xsE/H
Message-ID-Hash: UY3HCK6Z3TT3HEQH4MU6WIUIJQZLK2CX
X-Message-ID-Hash: UY3HCK6Z3TT3HEQH4MU6WIUIJQZLK2CX
X-MailFrom: maria.parker@bizcampaigns.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UY3HCK6Z3TT3HEQH4MU6WIUIJQZLK2CX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Would you be interested in acquiring HR Software Users List? 

And other updated contact databases of below specified titles or software
users that will add great value to your marketing programs. 

1.       Director, Human Resource 

2.       Director of Finance and Human Resources 

3.       Vice President Labor Relations 

4.       Vice President of Recruiting 

5.       Chief Human Resources Officer 

6.       Global Head of Human Resources 

7.       General Manager Human Resources 

8.       Owner, Human Resource Director and many more.

 

Data Field: verified Phone Number, Fax Number, Verified Email Address,
Employee Size, Revenue size, SIC Code, Industry Type and many more.

We provide data across the globe - North America, EMEA, Asia Pacific and
LATAM. 

Please let me know below format so that I can give you more information as
per your requirement and we will send you Price and Counts for your review.

 

Target Industry: ____ (Any Industry)

Target Geography: ____ (Any)

Target Job Title: ____ (EX: CEO, VP and Director)

 

Please review and let me know if you are looking for any type of list and we
can service you.

Warm Regards,

Maria Parker

Database coordinator

 

List acquisition | Technology Lists | Email/Data Appending | Search Engine
Optimization

To opt out please response Remove

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
