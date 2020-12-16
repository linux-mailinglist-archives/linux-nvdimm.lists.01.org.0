Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ED72DC943
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 23:54:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFDC8100EBB78;
	Wed, 16 Dec 2020 14:54:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 12F72100EBB76
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 14:54:01 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMnrf5082048;
	Wed, 16 Dec 2020 22:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1Mq8pvP2XSDA9gF8NugnkZh4cms2WkSo4JmoGtdLboE=;
 b=SQsCxeqMiyR69Anw77rb8X/s5v2etN5+9FEtgKOJbAnlWv7FCq9fVlEQ8EL/fOaJVAOe
 TjjmGWXNqq7m1ABUD6Iba5PTgeWwYGGK9N4HKyg6uqk6NPs/K5UdhsCzEaDrMtTAk6+L
 qdiw2Fm7L2g+7QB12iqpNRHK1gIPFvrhKWmbR3cD7GhMqGWi8WClXQ/SG37ryuf+3rW0
 1o+ywLxsMT4z4vEpS5lC3qUm3MNAD7La3+QLyKkTpxm9iXJJmRZPmsQVMpsRZrSonebq
 s3mSobRmfOPZVgJ9EJhHGHcuyubxdgW/pIJ1pBTO4EKZIauOCzM+krJS+PNn2uU//oDn BQ==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 35cntmasan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Dec 2020 22:53:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMoCST192773;
	Wed, 16 Dec 2020 22:53:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 35d7syghjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Dec 2020 22:53:58 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGMrvZa003193;
	Wed, 16 Dec 2020 22:53:57 GMT
Received: from [10.175.172.71] (/10.175.172.71)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 16 Dec 2020 14:53:57 -0800
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
To: Dan Williams <dan.j.williams@intel.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
 <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
 <9db17315af1440b805c4fed2338969e7fe3155ec.camel@intel.com>
 <1ba4fc06-a13a-ce2b-2f53-95a913ac3a8e@oracle.com>
 <CAPcyv4jiS07bGi+YRsMjAt37DCNwioTd8cd=LXKxOg-ARTM87g@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <01b3c6f8-901e-c9c8-6e98-88366d4ecbdd@oracle.com>
Date: Wed, 16 Dec 2020 22:53:54 +0000
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jiS07bGi+YRsMjAt37DCNwioTd8cd=LXKxOg-ARTM87g@mail.gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160142
Message-ID-Hash: GZ5G5F6SI5CJWW7KH2O6I6ZSYEALCIQ2
X-Message-ID-Hash: GZ5G5F6SI5CJWW7KH2O6I6ZSYEALCIQ2
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GZ5G5F6SI5CJWW7KH2O6I6ZSYEALCIQ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/16/20 10:31 PM, Dan Williams wrote:
> On Wed, Dec 16, 2020 at 1:51 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> On 12/16/20 6:42 PM, Verma, Vishal L wrote:
>>> On Wed, 2020-12-16 at 11:39 +0000, Joao Martins wrote:
>>>> On 7/16/20 7:46 PM, Joao Martins wrote:
>>>>> Hey,
>>>>>
>>>>> This series builds on top of this one[0] and does the following improvements
>>>>> to the Soft-Reserved subdivision:
>>>>>
>>>>>  1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
>>>>>  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
>>>>>
>>>>>  2) Listing improvements for device alignment and mappings;
>>>>>  Note: Perhaps it is better to hide the mappings by default, and only
>>>>>        print with -v|--verbose. This would align with ndctl, as the mappings
>>>>>        info can be quite large.
>>>>>
>>>>>  3) Allow creating devices from selecting ranges. This allows to keep the
>>>>>    same GPA->HPA mapping as before we kexec the hypervisor with running guests:
>>>>>
>>>>>    daxctl list -d dax0.1 > /var/log/dax0.1.json
>>>>>    kexec -d -l bzImage
>>>>>    systemctl kexec
>>>>>    daxctl create -u --restore /var/log/dax0.1.json
>>>>>
>>>>>    The JSON was what I though it would be easier for an user, given that it is
>>>>>    the data format daxctl outputs. Alternatives could be adding multiple:
>>>>>     --mapping <pgoff>:<start>-<end>
>>>>>
>>>>>    But that could end up in a gigantic line and a little more
>>>>>    unmanageable I think.
>>>>>
>>>>> This series requires this series[0] on top of Dan's patches[1]:
>>>>>
>>>>>  [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
>>>>>  [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/
>>>>>
>>>>> The only TODO here is docs and improving tests to validate mappings, and test
>>>>> the restore path.
>>>>>
>>>>> Suggestions/comments are welcome.
>>>>>
>>>> There's a couple of issues in this series regarding daxctl-reconfigure options and
>>>> breakage of ndctl with kernels (<5.10) that do not supply a device @align upon testing
>>>> with NVDIMMs. Plus it is missing daxctl-create.sh unit test for @align.
>>>>
>>>> I will fix those and respin, and probably take out the last patch as it's more RFC-ish and
>>>> in need of feedback.
>>>
>>> Sounds good. Any objections to releasing v70 with the initial support,
>>> and then adding this series on for the next one? I'm thinking I'll do a
>>> much quicker v72 release say in early January with this and anything
>>> else that missed v71.
>>
>> If we're able to wait until tomorrow, I could respin these first four patches with the
>> fixes and include the align support in the initial set. Otherwise, I am also good if you
>> prefer defering it to v72.
>>
> 
> Does this change the JSON output? Might be nice to keep that all in
> one update rather than invalidate some testing with the old format
> betweem v71 and v72.
> 
Ugh, sent the v2 too early before seeing this.

The only change to the output is on daxctl when listing devices for 5.10+.
It starts displaying an "align" key/value.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
