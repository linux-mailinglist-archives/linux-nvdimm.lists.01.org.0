Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713CF32B790
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Mar 2021 12:45:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ABDDF100EB32E;
	Wed,  3 Mar 2021 03:45:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D55AF100EB32A
	for <linux-nvdimm@lists.01.org>; Wed,  3 Mar 2021 03:45:13 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 2929EAD2B;
	Wed,  3 Mar 2021 11:45:12 +0000 (UTC)
Subject: Re: [RFC PATCH v1 1/6] badblocks: add more helper structure and
 routines in badblocks.h
To: Hannes Reinecke <hare@suse.de>
References: <20210302040252.103720-1-colyli@suse.de>
 <20210302040252.103720-2-colyli@suse.de>
 <96a899a9-151e-ff8c-c61c-900df1122357@suse.de>
From: Coly Li <colyli@suse.de>
Message-ID: <01aee83b-89d6-6048-ebfc-d07be1aaea7e@suse.de>
Date: Wed, 3 Mar 2021 19:45:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <96a899a9-151e-ff8c-c61c-900df1122357@suse.de>
Content-Language: en-US
Message-ID-Hash: JC2LKUZGTEPYAQGV6UN3HLDDY6PLSZP7
X-Message-ID-Hash: JC2LKUZGTEPYAQGV6UN3HLDDY6PLSZP7
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: antlists@youngman.org.uk, axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-block@vger.kernel.org, neilb@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JC2LKUZGTEPYAQGV6UN3HLDDY6PLSZP7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/3/21 4:20 PM, Hannes Reinecke wrote:
> On 3/2/21 5:02 AM, Coly Li wrote:
>> This patch adds the following helper structure and routines into
>> badblocks.h,
>> - struct bad_context
>>   This structure is used in improved badblocks code for bad table
>>   iteration.
>> - BB_END()
>>   The macro to culculate end LBA of a bad range record from bad
>>   table.
>> - badblocks_full() and badblocks_empty()
>>   The inline routines to check whether bad table is full or empty.
>> - set_changed() and clear_changed()
>>   The inline routines to set and clear 'changed' tag from struct
>>   badblocks.
>>
>> These new helper structure and routines can help to make the code more
>> clear, they will be used in the improved badblocks code in following
>> patches.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>>  include/linux/badblocks.h | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
>> index 2426276b9bd3..166161842d1f 100644
>> --- a/include/linux/badblocks.h
>> +++ b/include/linux/badblocks.h
>> @@ -15,6 +15,7 @@
>>  #define BB_OFFSET(x)	(((x) & BB_OFFSET_MASK) >> 9)
>>  #define BB_LEN(x)	(((x) & BB_LEN_MASK) + 1)
>>  #define BB_ACK(x)	(!!((x) & BB_ACK_MASK))
>> +#define BB_END(x)	(BB_OFFSET(x) + BB_LEN(x))
>>  #define BB_MAKE(a, l, ack) (((a)<<9) | ((l)-1) | ((u64)(!!(ack)) << 63))
>>  
>>  /* Bad block numbers are stored sorted in a single page.
>> @@ -41,6 +42,14 @@ struct badblocks {
>>  	sector_t size;		/* in sectors */
>>  };
>>  
>> +struct bad_context {
>> +	sector_t	start;
>> +	sector_t	len;
>> +	int		ack;
>> +	sector_t	orig_start;
>> +	sector_t	orig_len;
>> +};
>> +
> Maybe rename it to 'badblocks_context'.
> It's not the context which is bad ...
> 

Copied, I will modify it in next version.

Thanks for the suggestion.

Coly Li
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
