Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2383C372540
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 May 2021 06:59:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0A561100EB83F;
	Mon,  3 May 2021 21:59:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78D5B100EB83C
	for <linux-nvdimm@lists.01.org>; Mon,  3 May 2021 21:59:35 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1444iRKt193915;
	Tue, 4 May 2021 00:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=m2H0GCtMdQ905kNTgd/JP2rl9St7NsiZkP1diU1RmKw=;
 b=TEUcDBlwAwCVZ4tRy9ptx7SMtnJnRGMPcMNhGrCRjiKkOy/dDxjGfw4O+Q9fzpswX9hq
 g7AnY8xso0WcpJniOXVzNwQ7fjraDPfdXfBBHxnNVV3zrD2ltDjmcsTUHvnuCDSidqxY
 Ekb+A5ib1QKL53dpR9xdvVLLOEbQJf8i7uk0PwvpE+SgUclFq3LSbB/uMyGQifoKtq3r
 FUkDT5PRlpgAtADX9YdRSJdL11flMK1A/B6BYoSK9zKzgG4WMW6gd4QNkc3/HmBEd7iQ
 /6ONVHVGHAJNq8j1eZ2qYOPoxUdBjgjTlwEE/JteusXAy6B3wPVGykTStVhAqQcHAvu8 ww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38aygjg6wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 May 2021 00:59:21 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1444wg6s032689;
	Tue, 4 May 2021 00:59:21 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38aygjg6w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 May 2021 00:59:21 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1444xJF3013407;
	Tue, 4 May 2021 04:59:19 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma06fra.de.ibm.com with ESMTP id 388x8h8j47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 May 2021 04:59:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1444xGvx34079222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 May 2021 04:59:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A924E42041;
	Tue,  4 May 2021 04:59:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 376C44203F;
	Tue,  4 May 2021 04:59:12 +0000 (GMT)
Received: from [9.199.50.4] (unknown [9.199.50.4])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  4 May 2021 04:59:12 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
To: Dan Williams <dan.j.williams@intel.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <CAPcyv4gwkyDBG7EZOth-kcZR8Fb+RgGXY=Y9vbuHXAz3PAnLVw@mail.gmail.com>
 <bca3512d-5437-e8e6-68ae-0c9b887115f9@linux.ibm.com>
 <CAPcyv4hAOC89JOXr-ZCps=n8gEKD5W0jmGU1Enfo8ECVMf3veQ@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <d21fcac6-6a54-35fd-3088-6c56b85fbf25@linux.ibm.com>
Date: Tue, 4 May 2021 10:29:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hAOC89JOXr-ZCps=n8gEKD5W0jmGU1Enfo8ECVMf3veQ@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BNnxxzZrrD-sq9EhyaMEh4Q4j-zG-p0v
X-Proofpoint-ORIG-GUID: 002b9ZvWVgbyy83xiE_uyAvrr1UxNmU5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_01:2021-05-03,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040033
Message-ID-Hash: VT2ZYJEYEK6SOYCG3BGFY2LG4VCCUN4O
X-Message-ID-Hash: VT2ZYJEYEK6SOYCG3BGFY2LG4VCCUN4O
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, marcel.apfelbaum@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VT2ZYJEYEK6SOYCG3BGFY2LG4VCCUN4O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 5/4/21 1:11 AM, Dan Williams wrote:
> On Mon, May 3, 2021 at 7:06 AM Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>>


.....

> 
> The proposal that "sync-dax=unsafe" for non-PPC architectures, is a
> fundamental misrepresentation of how this is supposed to work. Rather
> than make "sync-dax" a first class citizen of the device-description
> interface I'm proposing that you make this a separate device-type.
> This also solves the problem that "sync-dax" with an implicit
> architecture backend assumption is not precise, but a new "non-nvdimm"
> device type would make it explicit what the host is advertising to the
> guest.
> 

Currently, users can use a virtualized nvdimm support in Qemu to share 
host page cache to the guest via the below command

-object memory-backend-file,id=memnvdimm1,mem-path=file_name_in_host_fs
-device nvdimm,memdev=memnvdimm1

Such usage can results in wrong application behavior because there is no 
hint to the application/guest OS that a cpu cache flush is not 
sufficient to ensure persistence.

I understand that virio-pmem is suggested as an alternative for that. 
But why not fix virtualized nvdimm if platforms can express the details.

ie, can ACPI indicate to the guest OS that the device need a flush 
mechanism to ensure persistence in the above case?

What this patch series did was to express that property via a device 
tree node and guest driver enables a hypercall based flush mechanism to 
ensure persistence.


....

>>
>> On PPC, the default is "sync-dax=writeback" - so the ND_REGION_ASYNC
>>
>> is set for the region and the guest makes hcalls to issue fsync on the host.
>>
>>
>> Are you suggesting me to keep it "unsafe" as default for all architectures
>>
>> including PPC and a user can set it to "writeback" if desired.
> 
> No, I am suggesting that "sync-dax" is insufficient to convey this
> property. This behavior warrants its own device type, not an ambiguous
> property of the memory-backend-file with implicit architecture
> assumptions attached.
> 

Why is it insufficient?  Is it because other architectures don't have an 
ability express this detail to guest OS? Isn't that an arch limitations?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
