Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF914E2C7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jan 2020 19:56:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E0DF1007B1F3;
	Thu, 30 Jan 2020 10:59:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=65.254.253.234; helo=walmailout08.yourhostingaccount.com; envelope-from=srs0=ifysml=3t=healthcaresurgeonsinfo.com=kelly.ellis@yourhostingaccount.com; receiver=<UNKNOWN> 
Received: from walmailout08.yourhostingaccount.com (walmailout08.yourhostingaccount.com [65.254.253.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 313281007B1F2
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 10:59:22 -0800 (PST)
Received: from mailscan12.yourhostingaccount.com ([10.1.15.12] helo=walmailscan12.yourhostingaccount.com)
	by walmailout08.yourhostingaccount.com with esmtp (Exim)
	id 1ixEyy-0005Eq-2j
	for linux-nvdimm@lists.01.org; Thu, 30 Jan 2020 13:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=healthcaresurgeonsinfo.com; s=dkim; h=Sender:Content-Type:MIME-Version:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=B4VO7//3QFPXLFnuhTG903HnF9QHeZZQrt26Qb93XP4=; b=y4qb298KnoEAdslHHcCo+1FF1
	rc2M92oGYqLCpBjZjxOYD90DWwaX2WHT7GxOuwJaH7M9XdivbMn3bJZiEizPVePaF+7hc2QIo3B2E
	6X3+x7IqGR2eCx4cLpkg80TAi6yt0mR7zjrtx2Agaj9vUDdaLLKRhltbYeS1GjvhYfM94tHPYrR1g
	YsINaZuRurq1G22d1aA5Vt0cAozMjOjFS+XSiPRy7x2OJOHPs+Yf9WQe5eYvmmwhnxayeSQGhHVvt
	JoFvD04P3BYwPqlGrxR4r8vjaphyIVhi6Wv85csMQ/ibyllxvyhkMMar3wVfm1VkqRf1QyZKLt6dI
	x2SiB4jHA==;
Received: from [10.114.3.32] (helo=walimpout12)
	by walmailscan12.yourhostingaccount.com with esmtp (Exim)
	id 1ixEyx-0004mK-UO
	for linux-nvdimm@lists.01.org; Thu, 30 Jan 2020 13:56:03 -0500
Received: from walauthsmtp04.yourhostingaccount.com ([10.1.18.4])
	by walimpout12 with
	id wivz2100205G96J01iw3hC; Thu, 30 Jan 2020 13:56:03 -0500
X-Authority-Analysis: v=2.2 cv=VeSHBBh9 c=1 sm=1 tr=0
 a=ZyCNx9LFiA0kwLx3ZJIN5w==:117 a=BCVGs1hZwUkc4kZbt9Q0Tg==:17
 a=Jdjhy38mL1oA:10 a=0GZ5hyYdzUwA:10 a=DAwyPP_o2Byb1YXLmDAA:9
 a=E3RZIj1sPfHVWjCndHEA:9 a=MruZ1--0asuU53jx:21 a=zcHbHTqKWggF2tRc:21
 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=5FofE1hMtPwC8AIrAfYA:9
 a=LihkpYpBGUBTQNBz:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
Received: from [49.205.217.195] (port=31293 helo=Admin)
	by walauthsmtp04.yourhostingaccount.com with esmtpa (Exim)
	id 1ixEyL-0001zD-PK
	for linux-nvdimm@lists.01.org; Thu, 30 Jan 2020 13:55:26 -0500
From: "Kelly Ellis" <kelly.ellis@healthcaresurgeonsinfo.com>
To: <linux-nvdimm@lists.01.org>
Subject: Healthcare Database Contact List
Date: Thu, 30 Jan 2020 10:50:42 -0800
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAABCb4pJORxKv4kuAF9Wq2vCgAAAEAAAAExn4aruo3NPs25jvkulb0UBAAAAAA==@healthcaresurgeonsinfo.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdXXnTgqE/0Av/r4T+qVZZsWWfASjg==
Content-Language: en-us
X-EN-UserInfo: 1b8510f31f753355e62a676c03f4c86e:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: kelly.ellis@healthcaresurgeonsinfo.com
Sender: "Kelly Ellis" <kelly.ellis@healthcaresurgeonsinfo.com>
X-EN-OrigIP: 49.205.217.195
X-EN-OrigHost: unknown
Message-ID-Hash: 2UKMQSGPJWEPNUKELLYLOCQOKYWKP4MS
X-Message-ID-Hash: 2UKMQSGPJWEPNUKELLYLOCQOKYWKP4MS
X-MailFrom: SRS0=ifySMl=3T=healthcaresurgeonsinfo.com=kelly.ellis@yourhostingaccount.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2UKMQSGPJWEPNUKELLYLOCQOKYWKP4MS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

As one of the leading Healthcare Database Provider, we have the fresh,
updated list which comprise complete contact details (verified Phone Number,
Fax Number, Verified Email Address, Employee Size, Revenue size, SIC Code,
Industry Type and many more).

 

Few of our lists mentioned below:

 

1) Anesthesiology Doctors List

2) Cardiology Doctors List

3) Chiropractic Doctors List

4) Dentist List

5) Dermatology Doctors List

6) Emergency Medicine Doctors List

7) Family Practice Doctors List

8) Gastroenterology Doctors List

9) Gynecology Doctors List

10) Hematology Doctors List

11) Internal medicine Doctors List

12) Neurology Doctors List

13) Obstetrics/Gynecology Doctors List

14) Oncology Doctors List

15) Ophthalmology Doctors List

16) Optometry Doctors List

17) Orthopedic Surgery Doctors List

18) Otorhinolaryngology Doctors List

19) Pathology Doctors List

20) Pediatrics Doctors List

21) Plastic Surgery Doctors List

22) Psychiatry Doctors List

23) Radiology Doctors List

24) Urology Doctors List

25) Nurse Mailing List

26) Registered Nurses (RN) List and many more.

 

Please let me know your target audience and geographical area, so that we
can send you more information about our services.

 

Regards,

Kelly Ellis 

Data Specialist

 

To remove from this mailing: reply with subject line as & leave out.

 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
