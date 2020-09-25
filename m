Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB52792EC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 23:06:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04BF614BEBC0E;
	Fri, 25 Sep 2020 14:06:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 024E214BEBC0D
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 14:06:08 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PL4ujO070257;
	Fri, 25 Sep 2020 21:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=t86XVzhzWTuiCcbgAP7XoJJMG7F0LY2LOCCc5kfef6w=;
 b=JS6NWECrTdeOhLOyVwhbOA1C+ryYoNX6WJUOefKakFRjRxKZWRTj3M5B1+f3dAGo/o9C
 udfICZ/Z2FvQ6coL4IfMrJE9WplLsVkcY2zA3mZr7SZdNoMbnn2oLmFKs7Zrnf/Chr2V
 1R4vXjk4d3COs3wbfL5ZIxPzrVOoivJ/n3+hKWewyFqYJor9qbAJbiMsfUCSFttqSZt+
 VgRW56X9lYfsORfUVaFcg42Qr48c9zwLh+2WBE2IsKWALbpmV12F6jFU1kxYuv345bzC
 hb6qsmrO2Auf6gbZgISvwEBgrAepzs6i5qIxnuzWNYxnRX+9zz5apwPWnZmuaHSZtfzM LQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 33ndnuytrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Sep 2020 21:05:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PL4WLq035167;
	Fri, 25 Sep 2020 21:05:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 33nurya5y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2020 21:05:34 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08PL5VAO022797;
	Fri, 25 Sep 2020 21:05:31 GMT
Received: from [10.175.187.87] (/10.175.187.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 25 Sep 2020 14:05:31 -0700
Subject: Re: [PATCH v5 00/17] device-dax: support sub-dividing soft-reserved
 ranges
To: Dan Williams <dan.j.williams@intel.com>
References: <160106109960.30709.7379926726669669398.stgit@dwillia2-desk3.amr.corp.intel.com>
 <8370d493-e38d-cbac-1233-14cbbef63936@oracle.com>
 <CAPcyv4je4PzCRo=Na7WfCpnvS0VpBN8qArr5HZv7jhwTNui4eg@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <11dbaa4a-5fe1-402e-e7d2-99e908b1bec0@oracle.com>
Date: Fri, 25 Sep 2020 22:05:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAPcyv4je4PzCRo=Na7WfCpnvS0VpBN8qArr5HZv7jhwTNui4eg@mail.gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250152
Message-ID-Hash: JFNVLK2DXCVKM3NUKXMOJ3NYIDPDY7KD
X-Message-ID-Hash: JFNVLK2DXCVKM3NUKXMOJ3NYIDPDY7KD
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Hulk Robot <hulkci@huawei.com>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jia He <justin.he@arm.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jason Yan <yanaijie@huawei.com>, Paul Mackerras <paulus@ozlabs.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brice Goglin <Brice.Goglin@inria.fr>, Stefano Stabellini <sstabellini@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel@ffwll.ch>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JFNVLK2DXCVKM3NUKXMOJ3NYIDPDY7KD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/25/20 10:01 PM, Dan Williams wrote:
> On Fri, Sep 25, 2020 at 1:52 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Hey Dan,
>>
>> On 9/25/20 8:11 PM, Dan Williams wrote:
>>> Changes since v4 [1]:
>>> - Rebased on
>>>   device-dax-move-instance-creation-parameters-to-struct-dev_dax_data.patch
>>>   in -mm [2]. I.e. patches that did not need fixups from v4 are not
>>>   included.
>>>
>>> - Folded all fixes
>>>
>>
>> Hmm, perhaps you missed the fixups before the above mentioned patch?
>>
>> From:
>>
>>         https://www.ozlabs.org/~akpm/mmots/series
>>
>> under "mm/dax", I am listing those fixups here:
>>
>> x86-numa-add-nohmat-option-fix.patch
>> acpi-hmat-refactor-hmat_register_target_device-to-hmem_register_device-fix.patch
>> mm-memory_hotplug-introduce-default-phys_to_target_node-implementation-fix.patch
>> acpi-hmat-attach-a-device-for-each-soft-reserved-range-fix.patch
>>
>> (in https://www.ozlabs.org/~akpm/mmots/broken-out/)
> 
> I left those for Andrew to handle. I actually should have started this
> set one more down in his stack because that's where my new changes
> start.
> 
Ah, got it!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
