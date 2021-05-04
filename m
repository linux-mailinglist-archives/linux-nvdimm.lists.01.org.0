Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9983727B9
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 May 2021 11:03:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 907C9100ED4A2;
	Tue,  4 May 2021 02:03:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 62359100EF267
	for <linux-nvdimm@lists.01.org>; Tue,  4 May 2021 02:03:14 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1448j0js066751;
	Tue, 4 May 2021 05:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hhDEWmzdghAGZtZeuFoepYTZTUQE5WKYZBIlzMAcUTA=;
 b=d7+vOBz1ri3+XgqQR42vv3qJScc1w4ZbNER4dpNQQ6ZglnvFfLQkKXqwrFTa3us9On2c
 pEE98fAtiWC3LY/+ZFZSkiJjRc4CUdOvfCEzlUqZQz8KOhoD08Yj4EWJMs2/9W96TvpW
 iLWMTYUNoOP2nnAdyrLgMbT2MY0MqKjTov6/yGXy+/RHjwmwqSor4HWjyZvD+Z1G1qhE
 dYGuVhF88ksA0/b/b2Kv2hzWj93ZhYnHj0wJb+k1xkOa5LNN4NG1SZhATHlnl7VFeSru
 Dr0VjU6Ap6yKVuAd1P1vO6t4ZESd7TAO+JrSV5B9BgoCQRACMArzuoH8KJ+H9VV6G/kG LQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 38b31g0e92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 May 2021 05:03:01 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1448j9SN067112;
	Tue, 4 May 2021 05:03:00 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 38b31g0e85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 May 2021 05:03:00 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
	by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1448xmtx021764;
	Tue, 4 May 2021 09:02:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma05fra.de.ibm.com with ESMTP id 388xm8gkv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 May 2021 09:02:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14492ttr32440578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 May 2021 09:02:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1ECE4204D;
	Tue,  4 May 2021 09:02:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20EEC42041;
	Tue,  4 May 2021 09:02:51 +0000 (GMT)
Received: from [9.199.50.4] (unknown [9.199.50.4])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  4 May 2021 09:02:50 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <CAPcyv4gwkyDBG7EZOth-kcZR8Fb+RgGXY=Y9vbuHXAz3PAnLVw@mail.gmail.com>
 <bca3512d-5437-e8e6-68ae-0c9b887115f9@linux.ibm.com>
 <CAPcyv4hAOC89JOXr-ZCps=n8gEKD5W0jmGU1Enfo8ECVMf3veQ@mail.gmail.com>
 <d21fcac6-6a54-35fd-3088-6c56b85fbf25@linux.ibm.com>
 <CAM9Jb+g8bKF0Z7za4sZpc2tZ01Sp4c4FEaV65He8w1+QOL3_yw@mail.gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <023e584a-6110-4d17-7fec-ca715226f869@linux.ibm.com>
Date: Tue, 4 May 2021 14:32:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+g8bKF0Z7za4sZpc2tZ01Sp4c4FEaV65He8w1+QOL3_yw@mail.gmail.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WyHOa4EB6zQCHAcN_OgqWSEtUI8wMYIe
X-Proofpoint-ORIG-GUID: KmKW0vgbGyeSeoxKHoyeFcbJvHRk7H6a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_05:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040062
Message-ID-Hash: TEU6RON4CILNUZ2WG2TGLLSL62ZG72HV
X-Message-ID-Hash: TEU6RON4CILNUZ2WG2TGLLSL62ZG72HV
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TEU6RON4CILNUZ2WG2TGLLSL62ZG72HV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 5/4/21 11:13 AM, Pankaj Gupta wrote:
....

>>
>> What this patch series did was to express that property via a device
>> tree node and guest driver enables a hypercall based flush mechanism to
>> ensure persistence.
> 
> Would VIRTIO (entirely asynchronous, no trap at host side) based
> mechanism is better
> than hyper-call based? Registering memory can be done any way. We
> implemented virtio-pmem
> flush mechanisms with below considerations:
> 
> - Proper semantic for guest flush requests.
> - Efficient mechanism for performance pov.
> 

sure, virio-pmem can be used as an alternative.

> I am just asking myself if we have platform agnostic mechanism already
> there, maybe
> we can extend it to suit our needs? Maybe I am missing some points here.
> 

What is being attempted in this series is to indicate to the guest OS 
that the backing device/file used for emulated nvdimm device cannot 
guarantee the persistence via cpu cache flush instructions.


>>>> On PPC, the default is "sync-dax=writeback" - so the ND_REGION_ASYNC
>>>>
>>>> is set for the region and the guest makes hcalls to issue fsync on the host.
>>>>
>>>>
>>>> Are you suggesting me to keep it "unsafe" as default for all architectures
>>>>
>>>> including PPC and a user can set it to "writeback" if desired.
>>>
>>> No, I am suggesting that "sync-dax" is insufficient to convey this
>>> property. This behavior warrants its own device type, not an ambiguous
>>> property of the memory-backend-file with implicit architecture
>>> assumptions attached.
>>>
>>
>> Why is it insufficient?  Is it because other architectures don't have an
>> ability express this detail to guest OS? Isn't that an arch limitations?

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
