Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF2834A85A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 14:45:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DD99C100EB355;
	Fri, 26 Mar 2021 06:45:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E110F100EF276
	for <linux-nvdimm@lists.01.org>; Fri, 26 Mar 2021 06:45:50 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12QDYFhK012278;
	Fri, 26 Mar 2021 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hN0aKM+lO6uutXnfbRXmXi0g8UDR1FbhTJDTauPMVfA=;
 b=KW5iwY4LBagg3jAZK0EPVylMDgcApBiM/dnAooLxKwxoPpvKN+DEbPEtfWukve5Yo8Hu
 1zdlfsK7zLkFdaHRWXk7wW5F+cldOG+WxmVmk3mk9sdzsEVt5IxuhOqrgA62XHWbiG6g
 5Tg9HeDylYCJzRdKHA3TPSWXsuqYf9dnDIjKGps8IuO094f10S2jcTWawhpAl9hnTVs4
 R1Jb7mj+X7VXNPwqw0WeTS1r9VPsIoZi3rLp3CYVfgqlHmDMssFqfjNUTS9st1tEAbuH
 CrPEQTIp0aptspzugQ9SzEfdW+NDcncZWcDoaJnMUC6T8haHxCqgB9Q4KYgC1BKTFEP/ pg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37hcdufnb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Mar 2021 09:45:43 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12QDYjL5018182;
	Fri, 26 Mar 2021 09:45:43 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37hcdufn93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Mar 2021 09:45:43 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12QDhoJJ028750;
	Fri, 26 Mar 2021 13:45:40 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma05fra.de.ibm.com with ESMTP id 37h14vgc2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Mar 2021 13:45:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12QDjc8T45941002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Mar 2021 13:45:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE3BD5204E;
	Fri, 26 Mar 2021 13:45:37 +0000 (GMT)
Received: from [9.199.49.154] (unknown [9.199.49.154])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A538B52054;
	Fri, 26 Mar 2021 13:45:33 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] spapr: nvdimm: Implement H_SCM_FLUSH hcall
To: David Gibson <david@gibson.dropbear.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
 <161650725183.2959.12071056430236337803.stgit@6532096d84d3>
 <YFqs8M1dHAFhdCL6@yekko.fritz.box>
 <19b5aa0b-df85-256d-d4c4-eacd0ea8312e@linux.ibm.com>
 <YFvsmKiXtb+h9HBO@yekko.fritz.box>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <8c642adb-7c07-41e1-07d0-f23bb6c2f865@linux.ibm.com>
Date: Fri, 26 Mar 2021 19:15:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <YFvsmKiXtb+h9HBO@yekko.fritz.box>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TfjaPP-Svek39ukV1IUMfj-VmbPxt41r
X-Proofpoint-ORIG-GUID: 9jkdStyqWjplPIyzdFqhl-2TNvJTeUAy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-26_06:2021-03-26,2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=887 clxscore=1015 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103260103
Message-ID-Hash: CMCFXMOJO25AA6AS3C7H4R5Y2MEND576
X-Message-ID-Hash: CMCFXMOJO25AA6AS3C7H4R5Y2MEND576
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: sbhat@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, qemu-devel@nongnu.org, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CMCFXMOJO25AA6AS3C7H4R5Y2MEND576/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

On 3/25/21 7:21 AM, David Gibson wrote:
> On Wed, Mar 24, 2021 at 09:34:06AM +0530, Aneesh Kumar K.V wrote:
>> On 3/24/21 8:37 AM, David Gibson wrote:
>>> On Tue, Mar 23, 2021 at 09:47:38AM -0400, Shivaprasad G Bhat wrote:
>>>> The patch adds support for the SCM flush hcall for the nvdimm devices.
...
>>>> collects all the hcall states from 'completed' list. The necessary
>>>> nvdimm flush specific vmstate structures are added to the spapr
>>>> machine vmstate.
>>>>
>>>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>> An overal question: surely the same issue must arise on x86 with
>>> file-backed NVDIMMs.  How do they handle this case?
>> On x86 we have different ways nvdimm can be discovered. ACPI NFIT, e820 =
map
>> and virtio_pmem. Among these virio_pmem always operated with synchronous=
 dax
>> disabled and both ACPI and e820 doesn't have the ability to differentiate
>> support for synchronous dax.
> Ok.  And for the virtio-pmem case, how are the extra flushes actually
> done on x86?


virtio-pmem device has virtqueue with virtio_pmem_flush() as the handler

which gets called for all flush requests from guest. virtio_pmem_flush() is

offloading the flush to thread pool with a worker doing fsync() and the

completion callback notifying the guest with response.


>> With that I would expect users to use virtio_pmem when using using file
>> backed NVDIMMS
> So... should we prevent advertising an NVDIMM through ACPI or e820 if
> it doesn't have sync-dax enabled?


Is it possible to have different defaults for sync-dax based on=20
architecture ?

The behaviour on x86 is sync-dax=3Don for nvdimms. So, it would be correct =
to

have the default as "on" for x86. For pseries -=A0 "off" for new machines.

Looking at code, I didnt find much ways to achieve this. Can you suggest

what can be done ?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
