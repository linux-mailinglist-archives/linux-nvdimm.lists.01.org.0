Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFC2DD040
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 12:23:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C75D8100EBB8F;
	Thu, 17 Dec 2020 03:23:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 97609100EC1DF
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 03:23:19 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHBE007172232;
	Thu, 17 Dec 2020 11:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=weaZy1FcO9tF2Pm3aiLwFbJg+XAMtIro1xUwACdzvFY=;
 b=oifhuml+L19ahPy32ymAN7Re3lfxd3OxY1Km9ZsAA99/zsftA9ueyUiZDZ1FfxtQTO18
 ai2MC7roZ7B4hvGeLNZSgJyPSwnEo/sRsCszUjYF7NySQMOwFvUEvg/xtZdU5mHEU6BX
 fLDQAUe1hJS7KnS8xz35IJmvx+NK5fgfKfeJUmNgQ3c3JG5Kfueu/Wa96q7RufiXO9IZ
 8VHXHdVL411MOm5WiZPQwNTTs0pk26fvN8iQH+gLiWTiu4B1g76igGxNW7YJ4NqXuCoA
 qRVivyJVCyG+FivMNLrwa+I0TVJRkbGw987kFVKF2DOrQOWY6DeoQoEHC6RXlTqFRVE+ cw==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 35cntmcv59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Dec 2020 11:23:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHBGFOn055221;
	Thu, 17 Dec 2020 11:23:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 35d7t06e8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Dec 2020 11:23:16 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BHBNF9E001857;
	Thu, 17 Dec 2020 11:23:15 GMT
Received: from [192.168.1.188] (/83.132.24.54)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 03:23:15 -0800
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
To: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
 <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
 <9db17315af1440b805c4fed2338969e7fe3155ec.camel@intel.com>
 <1ba4fc06-a13a-ce2b-2f53-95a913ac3a8e@oracle.com>
 <CAPcyv4jiS07bGi+YRsMjAt37DCNwioTd8cd=LXKxOg-ARTM87g@mail.gmail.com>
 <01b3c6f8-901e-c9c8-6e98-88366d4ecbdd@oracle.com>
 <CAPcyv4jQ9ee-o3t_Wy_4K-Nm5Lj6wJKv1pdjvtYQG6eJ3ejUrQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <b5a6577f-0384-8cbf-d3c7-2512f0f5d22c@oracle.com>
Date: Thu, 17 Dec 2020 11:23:10 +0000
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jQ9ee-o3t_Wy_4K-Nm5Lj6wJKv1pdjvtYQG6eJ3ejUrQ@mail.gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170082
Message-ID-Hash: RNIQNBRDMAVODHF3FLFVCZUZIBIBURFJ
X-Message-ID-Hash: RNIQNBRDMAVODHF3FLFVCZUZIBIBURFJ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RNIQNBRDMAVODHF3FLFVCZUZIBIBURFJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/16/20 11:42 PM, Dan Williams wrote:
> On Wed, Dec 16, 2020 at 2:54 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 12/16/20 10:31 PM, Dan Williams wrote:
>>> On Wed, Dec 16, 2020 at 1:51 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>> On 12/16/20 6:42 PM, Verma, Vishal L wrote:
>>>>> On Wed, 2020-12-16 at 11:39 +0000, Joao Martins wrote:
>>>>>> On 7/16/20 7:46 PM, Joao Martins wrote:
>>>>>>> Hey,
>>>>>>>
>>>>>>> This series builds on top of this one[0] and does the following improvements
>>>>>>> to the Soft-Reserved subdivision:
>>>>>>>
>>>>>>>  1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
>>>>>>>  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
>>>>>>>
>>>>>>>  2) Listing improvements for device alignment and mappings;
>>>>>>>  Note: Perhaps it is better to hide the mappings by default, and only
>>>>>>>        print with -v|--verbose. This would align with ndctl, as the mappings
>>>>>>>        info can be quite large.
>>>>>>>
>>>>>>>  3) Allow creating devices from selecting ranges. This allows to keep the
>>>>>>>    same GPA->HPA mapping as before we kexec the hypervisor with running guests:
>>>>>>>
>>>>>>>    daxctl list -d dax0.1 > /var/log/dax0.1.json
>>>>>>>    kexec -d -l bzImage
>>>>>>>    systemctl kexec
>>>>>>>    daxctl create -u --restore /var/log/dax0.1.json
>>>>>>>
>>>>>>>    The JSON was what I though it would be easier for an user, given that it is
>>>>>>>    the data format daxctl outputs. Alternatives could be adding multiple:
>>>>>>>     --mapping <pgoff>:<start>-<end>
>>>>>>>
>>>>>>>    But that could end up in a gigantic line and a little more
>>>>>>>    unmanageable I think.
>>>>>>>
>>>>>>> This series requires this series[0] on top of Dan's patches[1]:
>>>>>>>
>>>>>>>  [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
>>>>>>>  [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/
>>>>>>>
>>>>>>> The only TODO here is docs and improving tests to validate mappings, and test
>>>>>>> the restore path.
>>>>>>>
>>>>>>> Suggestions/comments are welcome.
>>>>>>>
>>>>>> There's a couple of issues in this series regarding daxctl-reconfigure options and
>>>>>> breakage of ndctl with kernels (<5.10) that do not supply a device @align upon testing
>>>>>> with NVDIMMs. Plus it is missing daxctl-create.sh unit test for @align.
>>>>>>
>>>>>> I will fix those and respin, and probably take out the last patch as it's more RFC-ish and
>>>>>> in need of feedback.
>>>>>
>>>>> Sounds good. Any objections to releasing v70 with the initial support,
>>>>> and then adding this series on for the next one? I'm thinking I'll do a
>>>>> much quicker v72 release say in early January with this and anything
>>>>> else that missed v71.
>>>>
>>>> If we're able to wait until tomorrow, I could respin these first four patches with the
>>>> fixes and include the align support in the initial set. Otherwise, I am also good if you
>>>> prefer defering it to v72.
>>>
>>> Does this change the JSON output? Might be nice to keep that all in
>>> one update rather than invalidate some testing with the old format
>>> betweem v71 and v72.
>>>
>> Ugh, sent the v2 too early before seeing this.
>>
>> The only change to the output is on daxctl when listing devices for 5.10+.
>> It starts displaying an "align" key/value.
> 
> No worries. Vishal and I chatted and it looks to me like your
> improvements to the provisioning flow are worthwhile to sneak into the
> v71 release if you want to include those changes as well.

The provisioning flow additions has some questions open about the daxctl
user interface. To summarize:

1) Should we always list mappings, or only list them with a -v option? Or
maybe instead of -v to use instead a new -M option which enables the
listing of mappings?

The reason being that it can get quite verbose with a device picks a lot
of mappings, hence I would imagine this info isn't necessary for the casual
daxctl listing.

2) Does the '--restore <file.json>' should instead be called it
instead '--device'? I feel the name '--restore' is too tied to one specific
way of using it when the feature can be used by a tool which wants to manage
its own range mappings. Additionally, I was thinking that if one wants to
manually add/fixup ranges more easily that we would add
a --mapping <pgoff>:<start>-<end> sort of syntax. But I suppose this could
be added later if its really desired.

And with these clarified, I could respin it over. Oh and I'm missing a
mappings test as well.

It's worth mentioning that kexec will need fixing, as dax_hmem regions
created with HMAT or manually assigned with efi_fake_mem= get lost on
kexec because we do not pass the EFI_MEMMAP conventional memory ranges
to the second kernel (only runtime code/boot services). I have a
RFC patch for x86 efi handling, but should get that conversation started
after holidays.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
