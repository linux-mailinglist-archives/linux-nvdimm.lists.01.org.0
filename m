Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5725A19068E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 08:45:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E4B5F10FC38A6;
	Tue, 24 Mar 2020 00:46:42 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sachinp@linux.vnet.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15BCC10FC38A5
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 00:46:40 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O7XX4r087980
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 03:45:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ywdr5u380-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 24 Mar 2020 03:45:48 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <sachinp@linux.vnet.ibm.com>;
	Tue, 24 Mar 2020 07:45:44 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 24 Mar 2020 07:45:41 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O7iecg49021290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2020 07:44:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B24624C058;
	Tue, 24 Mar 2020 07:45:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45AD14C052;
	Tue, 24 Mar 2020 07:45:40 +0000 (GMT)
Received: from [9.199.50.248] (unknown [9.199.50.248])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2020 07:45:40 +0000 (GMT)
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
Date: Tue, 24 Mar 2020 13:15:39 +0530
In-Reply-To: <20200324070742.GJ2987@MiWiFi-R3L-srv>
To: Baoquan He <bhe@redhat.com>
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
 <20200324070742.GJ2987@MiWiFi-R3L-srv>
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 20032407-0020-0000-0000-000003B9FDDD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032407-0021-0000-0000-000022127D24
Message-Id: <27F1FD2E-28A3-47AF-BFB0-409D1A19A1C2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_01:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=745 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240039
Message-ID-Hash: QVACY3PZY2MYVQXDYZJDJV7Y4M3MBEZO
X-Message-ID-Hash: QVACY3PZY2MYVQXDYZJDJV7Y4M3MBEZO
X-MailFrom: sachinp@linux.vnet.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QVACY3PZY2MYVQXDYZJDJV7Y4M3MBEZO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> On 24-Mar-2020, at 12:37 PM, Baoquan He <bhe@redhat.com> wrote:
> 
> Hi Sachin,
> 
> On 03/24/20 at 11:25am, Sachin Sant wrote:
>> While running ndctl[1] tests against 5.6.0-rc7 following crash is encountered.
>> 
>> Bisect leads me to  commit d41e2f3bd546 
>> mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
>> 
>> Reverting this commit helps and the tests complete without any crash.
> 
> Could you paste your kernel config and the boot log?
> 

I have attached boot.log as well as kernel config.

Thanks
-Sachin

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
