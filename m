Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021B4371666
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 May 2021 16:05:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 93A26100EB35B;
	Mon,  3 May 2021 07:05:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5C6F9100EB35A
	for <linux-nvdimm@lists.01.org>; Mon,  3 May 2021 07:05:46 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143E4cZ1010692;
	Mon, 3 May 2021 10:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ub82Zb+3cNGTmoNKsbzlVfaHCGXa/5g9YCQb43mnMl0=;
 b=SM4i+xEXBBCmeeUJl4dGq/OTydqA4GWa5UTgrPqq7HakY2P4SGdW/+F/bE8uDznW90j9
 3lGRgkR0zoYJQzA8mXHgBe9bu1VhulCJMaKvqDoI8+MG8Tj46aggF8NHjy7wYheyw0xI
 XwIGgqBH9bHlbbuAdCBE74BNENgWjDqB3k6cOXsWkjYoqxZSNghIGkWMaY/EuuD419pk
 BkxAYtVb9+XiYNxYhcaVf7Vx8p2AAJTPFnJUlwW1f2BMmkSM9RRPHp7kS95ijkDwixvG
 L82ngaoptvkLUVj92NV1h5si1nIzpyfkz16rR5FSzvmFksQDAOAupSmngNK9yAE33IRA Dw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38aj1s12j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 May 2021 10:05:33 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 143E4k8R011488;
	Mon, 3 May 2021 10:05:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38aj1s12ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 May 2021 10:05:33 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 143E3LVA020317;
	Mon, 3 May 2021 14:05:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma04ams.nl.ibm.com with ESMTP id 388xm8rrcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 May 2021 14:05:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 143E5RIO22675926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 May 2021 14:05:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72037AE059;
	Mon,  3 May 2021 14:05:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C43BAE058;
	Mon,  3 May 2021 14:05:22 +0000 (GMT)
Received: from [9.102.24.175] (unknown [9.102.24.175])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  3 May 2021 14:05:22 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
To: Dan Williams <dan.j.williams@intel.com>
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <CAPcyv4gwkyDBG7EZOth-kcZR8Fb+RgGXY=Y9vbuHXAz3PAnLVw@mail.gmail.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <bca3512d-5437-e8e6-68ae-0c9b887115f9@linux.ibm.com>
Date: Mon, 3 May 2021 19:35:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CAPcyv4gwkyDBG7EZOth-kcZR8Fb+RgGXY=Y9vbuHXAz3PAnLVw@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TDjsG8pL4Yzek7UVYO-MoCo6_XkVPZeK
X-Proofpoint-ORIG-GUID: d6OOTyIyZHWDsza4bb-2GnoBTlwiTCgT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_10:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030096
Message-ID-Hash: NZEAN23OQEYKOGDYTIAHJIREOUNWDLVJ
X-Message-ID-Hash: NZEAN23OQEYKOGDYTIAHJIREOUNWDLVJ
X-MailFrom: sbhat@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, marcel.apfelbaum@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NZEAN23OQEYKOGDYTIAHJIREOUNWDLVJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit


On 5/1/21 12:44 AM, Dan Williams wrote:
> Some corrections to terminology confusion below...
>
>
> On Wed, Apr 28, 2021 at 8:49 PM Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>> The nvdimm devices are expected to ensure write persistence during power
>> failure kind of scenarios.
> No, QEMU is not expected to make that guarantee. QEMU is free to lie
> to the guest about the persistence guarantees of the guest PMEM
> ranges. It's more accurate to say that QEMU nvdimm devices can emulate
> persistent memory and optionally pass through host power-fail
> persistence guarantees to the guest. The power-fail persistence domain
> can be one of "cpu_cache", or "memory_controller" if the persistent
> memory region is "synchronous". If the persistent range is not
> synchronous, it really isn't "persistent memory"; it's memory mapped
> storage that needs I/O commands to flush.

Since this is virtual nvdimm(v-nvdimm) backed by a file, and the data is 
completely

in the host pagecache, and we need a way to ensure that host pagecaches

are flushed to the backend. This analogous to the WPQ flush being offloaded

to the hypervisor.


Ref: https://github.com/dgibson/qemu/blob/main/docs/nvdimm.txt


>
>> The libpmem has architecture specific instructions like dcbf on POWER
> Which "libpmem" is this? PMDK is a reference library not a PMEM
> interface... maybe I'm missing what libpmem has to do with QEMU?


I was referrering to semantics of flushing pmem cache lines as in

PMDK/libpmem.


>
>> to flush the cache data to backend nvdimm device during normal writes
>> followed by explicit flushes if the backend devices are not synchronous
>> DAX capable.
>>
>> Qemu - virtual nvdimm devices are memory mapped. The dcbf in the guest
>> and the subsequent flush doesn't traslate to actual flush to the backend
> s/traslate/translate/
>
>> file on the host in case of file backed v-nvdimms. This is addressed by
>> virtio-pmem in case of x86_64 by making explicit flushes translating to
>> fsync at qemu.
> Note that virtio-pmem was a proposal for a specific optimization of
> allowing guests to share page cache. The virtio-pmem approach is not
> to be confused with actual persistent memory.
>
>> On SPAPR, the issue is addressed by adding a new hcall to
>> request for an explicit flush from the guest ndctl driver when the backend
> What is an "ndctl" driver? ndctl is userspace tooling, do you mean the
> guest pmem driver?


oops, wrong terminologies. I was referring to guest libnvdimm and

papr_scm kernel modules.


>
>> nvdimm cannot ensure write persistence with dcbf alone. So, the approach
>> here is to convey when the hcall flush is required in a device tree
>> property. The guest makes the hcall when the property is found, instead
>> of relying on dcbf.
>>
>> A new device property sync-dax is added to the nvdimm device. When the
>> sync-dax is 'writeback'(default for PPC), device property
>> "hcall-flush-required" is set, and the guest makes hcall H_SCM_FLUSH
>> requesting for an explicit flush.
> I'm not sure "sync-dax" is a suitable name for the property of the
> guest persistent memory.


sync-dax property translates ND_REGION_ASYNC flag being set/unset

for the pmem region also if the nvdimm_flush callback is provided in the

papr_scm or not. As everything boils down to synchronous nature

of the device, I chose sync-dax for the name.


>   There is no requirement that the
> memory-backend file for a guest be a dax-capable file. It's also
> implementation specific what hypercall needs to be invoked for a given
> occurrence of "sync-dax". What does that map to on non-PPC platforms
> for example?


The backend file can be dax-capable, to be hinted using "sync-dax=direct".

When the backend is not dax-capable, the "sync-dax=writeback" to used,

so that the guest makes the hcall. On all non-PPC archs, with the

"sync-dax=writeback" qemu errors out stating the lack of support.


>   It seems to me that an "nvdimm" device presents the
> synchronous usage model and a whole other device type implements an
> async-hypercall setup that the guest happens to service with its
> nvdimm stack, but it's not an "nvdimm" anymore at that point.


In case the file backing the v-nvdimm is not dax-capable, we need flush

semantics on the guest to be mapped to pagecache flush on the host side.


>
>> sync-dax is "unsafe" on all other platforms(x86, ARM) and old pseries machines
>> prior to 5.2 on PPC. sync-dax="writeback" on ARM and x86_64 is prevented
>> now as the flush semantics are unimplemented.
> "sync-dax" has no meaning on its own, I think this needs an explicit
> mechanism to convey both the "not-sync" property *and* the callback
> method, it shouldn't be inferred by arch type.


Yes. On all platforms the "sync-dax=unsafe" meaning - with host power

failure the host pagecache is lost and subsequently data written by the

guest will also be gone. This is the default for non-PPC.


On PPC, the default is "sync-dax=writeback" - so the ND_REGION_ASYNC

is set for the region and the guest makes hcalls to issue fsync on the host.


Are you suggesting me to keep it "unsafe" as default for all architectures

including PPC and a user can set it to "writeback" if desired.


>
>> When the backend file is actually synchronous DAX capable and no explicit
>> flushes are required, the sync-dax mode 'direct' is to be used.
>>
>> The below demonstration shows the map_sync behavior with sync-dax writeback &
>> direct.
>> (https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/memory/ndctl.py.data/map_sync.c)
>>
>> The pmem0 is from nvdimm with With sync-dax=direct, and pmem1 is from
>> nvdimm with syn-dax=writeback, mounted as
>> /dev/pmem0 on /mnt1 type xfs (rw,relatime,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)
>> /dev/pmem1 on /mnt2 type xfs (rw,relatime,attr2,dax=always,inode64,logbufs=8,logbsize=32k,noquota)
>>
>> [root@atest-guest ~]# ./mapsync /mnt1/newfile ----> When sync-dax=unsafe/direct
>> [root@atest-guest ~]# ./mapsync /mnt2/newfile ----> when sync-dax=writeback
>> Failed to mmap  with Operation not supported
>>
>> The first patch does the header file cleanup necessary for the
>> subsequent ones. Second patch implements the hcall, adds the necessary
>> vmstate properties to spapr machine structure for carrying the hcall
>> status during save-restore. The nature of the hcall being asynchronus,
>> the patch uses aio utilities to offload the flush. The third patch adds
>> the 'sync-dax' device property and enables the device tree property
>> for the guest to utilise the hcall.
>>
>> The kernel changes to exploit this hcall is at
>> https://github.com/linuxppc/linux/commit/75b7c05ebf9026.patch
>>
>> ---
>> v3 - https://lists.gnu.org/archive/html/qemu-devel/2021-03/msg07916.html
>> Changes from v3:
>>        - Fixed the forward declaration coding guideline violations in 1st patch.
>>        - Removed the code waiting for the flushes to complete during migration,
>>          instead restart the flush worker on destination qemu in post load.
>>        - Got rid of the randomization of the flush tokens, using simple
>>          counter.
>>        - Got rid of the redundant flush state lock, relying on the BQL now.
>>        - Handling the memory-backend-ram usage
>>        - Changed the sync-dax symantics from on/off to 'unsafe','writeback' and 'direct'.
>>          Added prevention code using 'writeback' on arm and x86_64.
>>        - Fixed all the miscellaneous comments.
>>
>> v2 - https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg07031.html
>> Changes from v2:
>>        - Using the thread pool based approach as suggested
>>        - Moved the async hcall handling code to spapr_nvdimm.c along
>>          with some simplifications
>>        - Added vmstate to preserve the hcall status during save-restore
>>          along with pre_save handler code to complete all ongoning flushes.
>>        - Added hw_compat magic for sync-dax 'on' on previous machines.
>>        - Miscellanious minor fixes.
>>
>> v1 - https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg06330.html
>> Changes from v1
>>        - Fixed a missed-out unlock
>>        - using QLIST_FOREACH instead of QLIST_FOREACH_SAFE while generating token
>>
>> Shivaprasad G Bhat (3):
>>        spapr: nvdimm: Forward declare and move the definitions
>>        spapr: nvdimm: Implement H_SCM_FLUSH hcall
>>        nvdimm: Enable sync-dax device property for nvdimm
>>
>>
>>   hw/arm/virt.c                 |   28 ++++
>>   hw/i386/pc.c                  |   28 ++++
>>   hw/mem/nvdimm.c               |   52 +++++++
>>   hw/ppc/spapr.c                |   16 ++
>>   hw/ppc/spapr_nvdimm.c         |  285 +++++++++++++++++++++++++++++++++++++++++
>>   include/hw/mem/nvdimm.h       |   11 ++
>>   include/hw/ppc/spapr.h        |   11 +-
>>   include/hw/ppc/spapr_nvdimm.h |   27 ++--
>>   qapi/common.json              |   20 +++
>>   9 files changed, 455 insertions(+), 23 deletions(-)
>>
>> --
>> Signature
>> _______________________________________________
>> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
>> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
