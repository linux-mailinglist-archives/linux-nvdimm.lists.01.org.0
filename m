Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435936EE34
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Apr 2021 18:32:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFAF6100EB844;
	Thu, 29 Apr 2021 09:32:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 28A4E100EB839
	for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 09:32:52 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13TGWciS000811;
	Thu, 29 Apr 2021 12:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TKa6vFQRppYLh2+mwZthIR6zPZEfRNZrMya+Tyu1qcg=;
 b=TuIWnYI+ZZIsvN7CbPAbatYU5csnKyf/+0dIyiQxl+bWWfCJxcUEythsxnLFCGQaV5d5
 0uR0ti6YHNwNeSrZqAxKt2go6uoQ/whl912nDZEXxr3q87npqfoLygIXbsfUZ7UGlTua
 XDVvBLZAu+CuUWU96BP6i20bVMKlxt42Ppb8WdUq9tzkFzQ4fUjxT9+xBqCI048wVl73
 he5JB++KbkJJAqRivqaEc1ylzWRM4mgQNe7nde9BIFyiCDb2gD6o5JLuHh+bWM+TzY+m
 G5U3hUiM/zBxCRgO2w2s9o6oh6kWx2X3ahnI2W71v/YNooYxkChwg14qsNJPYLt7ZUD0 tg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38807d8av1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Apr 2021 12:32:40 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13TGWdmg000842;
	Thu, 29 Apr 2021 12:32:39 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38807d8au4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Apr 2021 12:32:39 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13TGO8Tt010918;
	Thu, 29 Apr 2021 16:32:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma03ams.nl.ibm.com with ESMTP id 384ay8jhhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Apr 2021 16:32:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13TGWVn226738988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Apr 2021 16:32:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B697AA4054;
	Thu, 29 Apr 2021 16:32:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C57A405F;
	Thu, 29 Apr 2021 16:32:24 +0000 (GMT)
Received: from [9.85.83.17] (unknown [9.85.83.17])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 29 Apr 2021 16:32:24 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
To: Stefan Hajnoczi <stefanha@redhat.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <YIrW4bwbR1R0CWm/@stefanha-x1.localdomain>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <433e352d-5341-520c-5c57-79650277a719@linux.ibm.com>
Date: Thu, 29 Apr 2021 22:02:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIrW4bwbR1R0CWm/@stefanha-x1.localdomain>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vs4gmYYnxxjSSi7Ue87hSFLIW-pbo7R3
X-Proofpoint-ORIG-GUID: JEqIWA59kgKo8hFInSvLjaNQgNU_Sg5Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_08:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290102
Message-ID-Hash: YGLGGISROMSH7CZ7F6S5UKASLBHNWRCU
X-Message-ID-Hash: YGLGGISROMSH7CZ7F6S5UKASLBHNWRCU
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: david@gibson.dropbear.id.au, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, peter.maydell@linaro.org, eblake@redhat.com, qemu-arm@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, haozhong.zhang@intel.com, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, armbru@redhat.com, qemu-devel@nongnu.org, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YGLGGISROMSH7CZ7F6S5UKASLBHNWRCU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 4/29/21 9:25 PM, Stefan Hajnoczi wrote:
> On Wed, Apr 28, 2021 at 11:48:21PM -0400, Shivaprasad G Bhat wrote:
>> The nvdimm devices are expected to ensure write persistence during power
>> failure kind of scenarios.
>>
>> The libpmem has architecture specific instructions like dcbf on POWER
>> to flush the cache data to backend nvdimm device during normal writes
>> followed by explicit flushes if the backend devices are not synchronous
>> DAX capable.
>>
>> Qemu - virtual nvdimm devices are memory mapped. The dcbf in the guest
>> and the subsequent flush doesn't traslate to actual flush to the backend
>> file on the host in case of file backed v-nvdimms. This is addressed by
>> virtio-pmem in case of x86_64 by making explicit flushes translating to
>> fsync at qemu.
>>
>> On SPAPR, the issue is addressed by adding a new hcall to
>> request for an explicit flush from the guest ndctl driver when the backend
>> nvdimm cannot ensure write persistence with dcbf alone. So, the approach
>> here is to convey when the hcall flush is required in a device tree
>> property. The guest makes the hcall when the property is found, instead
>> of relying on dcbf.
> 
> Sorry, I'm not very familiar with SPAPR. Why add a hypercall when the
> virtio-nvdimm device already exists?
> 

On virtualized ppc64 platforms, guests use papr_scm.ko kernel drive for 
persistent memory support. This was done such that we can use one kernel 
driver to support persistent memory with multiple hypervisors. To avoid 
supporting multiple drivers in the guest, -device nvdimm Qemu 
command-line results in Qemu using PAPR SCM backend. What this patch 
series does is to make sure we expose the correct synchronous fault 
support, when we back such nvdimm device with a file.

The existing PAPR SCM backend enables persistent memory support with the 
help of multiple hypercall.

#define H_SCM_READ_METADATA     0x3E4
#define H_SCM_WRITE_METADATA    0x3E8
#define H_SCM_BIND_MEM          0x3EC
#define H_SCM_UNBIND_MEM        0x3F0
#define H_SCM_UNBIND_ALL        0x3FC

Most of them are already implemented in Qemu. This patch series 
implements H_SCM_FLUSH hypercall.




-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
