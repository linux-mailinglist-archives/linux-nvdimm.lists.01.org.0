Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C435EC1C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Apr 2021 07:20:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B71A0100F2257;
	Tue, 13 Apr 2021 22:20:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F4B4100F2255
	for <linux-nvdimm@lists.01.org>; Tue, 13 Apr 2021 22:20:50 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13E53Gq6095394;
	Wed, 14 Apr 2021 01:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=+vwG3u3iIJPG/PKR7v/p3EeHOl8MGusq6Iepzq3DwWU=;
 b=d4TX/QcPMfADRL9KVfaRYfODhn4FsZ2yB3WSPGXXB4nFc2beLvn30zwl+oklMmtt6mSR
 11PYEgFTpFXqkKHLdAmMT6sGMvv0r6cBTkKZLGiuQ0hlWW+F2mDckPnt6ik1OCre3grF
 Dhl5T5mJZIkXhBtXEthFFupbPwX1pm7jRsat1gWC9dvlQgkOUup5NFynLRMmeVRNfd0i
 OIkKrihKI54UV8F0kuneP75CzFcyK+e8Gi01DNj5RyWGiyGET4ZWDXZ5ew2PobLD9wjK
 39gnGHtqQd/iGeVLbG4yt4ya73Z5Ze0m3DKpPXzHM6fcyXyPDVSk3Ks8D9HvQmzosQCe SA==
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 37vjtuxtu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Apr 2021 01:20:49 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13E5HuEY003027;
	Wed, 14 Apr 2021 05:20:48 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by ppma01dal.us.ibm.com with ESMTP id 37u3n9p3yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Apr 2021 05:20:48 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13E5KlWw19595690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Apr 2021 05:20:48 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C688D112063;
	Wed, 14 Apr 2021 05:20:47 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2749112061;
	Wed, 14 Apr 2021 05:20:44 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.77.205.193])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 14 Apr 2021 05:20:44 +0000 (GMT)
X-Mailer: emacs 27.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>, sbhat@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-nvdimm@lists.01.org, ellerman@au1.ibm.com
Subject: Re: [PATCH v3] powerpc/papr_scm: Implement support for H_SCM_FLUSH
 hcall
In-Reply-To: <87sg3ujmrm.fsf@vajain21.in.ibm.com>
References: <161703936121.36.7260632399582101498.stgit@e1fbed493c87>
 <87sg3ujmrm.fsf@vajain21.in.ibm.com>
Date: Wed, 14 Apr 2021 10:50:42 +0530
Message-ID: <877dl530id.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8ZQICP9aX4lphGsoIi4A2MSJqLUmlzWR
X-Proofpoint-ORIG-GUID: 8ZQICP9aX4lphGsoIi4A2MSJqLUmlzWR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_01:2021-04-13,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140034
Message-ID-Hash: Z7JSBEJGO4NCNWYMZH7TLUTFIW53FMRT
X-Message-ID-Hash: Z7JSBEJGO4NCNWYMZH7TLUTFIW53FMRT
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-doc@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z7JSBEJGO4NCNWYMZH7TLUTFIW53FMRT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Hi Shiva,
>
> Apologies for a late review but something just caught my eye while
> working on a different patch.
>
> Shivaprasad G Bhat <sbhat@linux.ibm.com> writes:
>
>> Add support for ND_REGION_ASYNC capability if the device tree
>> indicates 'ibm,hcall-flush-required' property in the NVDIMM node.
>> Flush is done by issuing H_SCM_FLUSH hcall to the hypervisor.
>>
>> If the flush request failed, the hypervisor is expected to
>> to reflect the problem in the subsequent nvdimm H_SCM_HEALTH call.
>>
>> This patch prevents mmap of namespaces with MAP_SYNC flag if the
>> nvdimm requires an explicit flush[1].
>>
>> References:
>> [1] https://github.com/avocado-framework-tests/avocado-misc-tests/blob/master/memory/ndctl.py.data/map_sync.c
>>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> ---
>> v2 - https://www.spinics.net/lists/kvm-ppc/msg18799.html
>> Changes from v2:
>>        - Fixed the commit message.
>>        - Add dev_dbg before the H_SCM_FLUSH hcall
>>
>> v1 - https://www.spinics.net/lists/kvm-ppc/msg18272.html
>> Changes from v1:
>>        - Hcall semantics finalized, all changes are to accomodate them.
>>
>>  Documentation/powerpc/papr_hcalls.rst     |   14 ++++++++++
>>  arch/powerpc/include/asm/hvcall.h         |    3 +-
>>  arch/powerpc/platforms/pseries/papr_scm.c |   40 +++++++++++++++++++++++++++++
>>  3 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
>> index 48fcf1255a33..648f278eea8f 100644
>> --- a/Documentation/powerpc/papr_hcalls.rst
>> +++ b/Documentation/powerpc/papr_hcalls.rst
>> @@ -275,6 +275,20 @@ Health Bitmap Flags:
>>  Given a DRC Index collect the performance statistics for NVDIMM and copy them
>>  to the resultBuffer.
>>  
>> +**H_SCM_FLUSH**
>> +
>> +| Input: *drcIndex, continue-token*
>> +| Out: *continue-token*
>> +| Return Value: *H_SUCCESS, H_Parameter, H_P2, H_BUSY*
>> +
>> +Given a DRC Index Flush the data to backend NVDIMM device.
>> +
>> +The hcall returns H_BUSY when the flush takes longer time and the hcall needs
>> +to be issued multiple times in order to be completely serviced. The
>> +*continue-token* from the output to be passed in the argument list of
>> +subsequent hcalls to the hypervisor until the hcall is completely serviced
>> +at which point H_SUCCESS or other error is returned by the hypervisor.
>> +
> Does the hcall semantic also include measures to trigger a barrier/fence
> (like pm_wmb()) so that all the stores before the hcall are gauranteed
> to have hit the pmem controller ?

It is upto the hypervisor to implement the right sequence to ensure the
guarantee. The hcall doesn't expect the store to reach the platform
buffers.


>
> If not then the papr_scm_pmem_flush() introduced below should issue a
> fence like pm_wmb() before issuing the flush hcall.
>
> If yes then this behaviour should also be documented with the hcall
> semantics above.
>

IIUC fdatasync on the backend file is enough to ensure the
guaraantee. Such a request will have REQ_PREFLUSH and REQ_FUA which will
do the necessary barrier on the backing device holding the backend file.

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
