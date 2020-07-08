Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB22217F9D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 08:33:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 95A5A110BA974;
	Tue,  7 Jul 2020 23:33:16 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A4532110BA973
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 23:33:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so14316073pgm.11
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jul 2020 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pOKLrhFd+Wz25ELD7U8n3o8/57LycSlMKk33eZ4LVvA=;
        b=d5W67kHzvJt+QoyBtwwl4Ly8jzP84q2oI+s3CatsZei/K4hx9sPTf1oi9WNxEHZYiz
         oXDC98Xryuyv8yMKUo4Xgkk8xNDdtP/SjOqRa1twZlV7rw1CwbdKRmgeBhHTO88J0GNh
         f4jlVcBhAL3Ocqx6enlAABj6N6dwhd4pI/8i+1OD9mxd0PnmifZocp60DrpAtQBwZmiZ
         6sTLpmOTPhZcf5F+R0ViuXiFDb/KJmG8K4RQEGqNMTujuZWj3mRTY7DWl5NnjeN0iUK6
         WsZ7FilNItRZmU+wBvDfJ+WmQI2qbrIzYclpx5/KgaDXxPrv3aB6dAQnkIkp4Ig0QTvq
         9IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pOKLrhFd+Wz25ELD7U8n3o8/57LycSlMKk33eZ4LVvA=;
        b=uW9YCdaKiTaCxmmlUFh3CCq8AcfhNd0jX7SZwaEGgwmSXShVwK/n3C8ot0Bi7zcX3Y
         cgQ/y54B7vUkVIGSTX2wOpfHKqd6ugMkgXaNS0IL39CTQbHN9lG/66BFYP8Xi6EQRV9e
         2hS9KOD/xrjjV4IuQg5U0xIak9CvJ+DxW+i/zPhAK0OESZxpsNV+twwQAXs+AnmO/A22
         wsbl0XmXWuzG5usv0sbygUjP8I7gFaW9Tn2CW38kmsJG5iOJYx8qVKwehK+BNpsJpYsz
         uRgGh0bq05dGI4NOdVq9rVfaIFhmo7mo93pBoBq+gaCJcbthrKc599WK9RkIF2I2PDN+
         rz9Q==
X-Gm-Message-State: AOAM533GW2pbE6pCQf2YglHNKZQ3Cp2ZG7T+c8g9eV0fHn7jphHjLQY7
	3xs+vcm+oB5Hd7XWe0/ppj2VOLSwUJk=
X-Google-Smtp-Source: ABdhPJx2gfAPiqvvNkDMKquOZIFXEgGmKYVdE59j6yffvWT8bpJjI5h2ZWh6YUOMuVRVvxxyYtpy4Q==
X-Received: by 2002:a65:6799:: with SMTP id e25mr50303205pgr.364.1594189992879;
        Tue, 07 Jul 2020 23:33:12 -0700 (PDT)
Received: from localhost ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id k63sm3048736pge.0.2020.07.07.23.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 23:33:12 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH ndctl] infoblock: Set the default alignment to the platform alignment
In-Reply-To: <20200707211258.GD961523@iweiny-DESK2.sc.intel.com>
References: <20200707005641.3936295-1-santosh@fossix.org> <20200707211258.GD961523@iweiny-DESK2.sc.intel.com>
Date: Wed, 08 Jul 2020 12:03:09 +0530
Message-ID: <87r1tmy0re.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: 7UAGESVQMAUSCYPG3LGZGWTX5S2FSAH5
X-Message-ID-Hash: 7UAGESVQMAUSCYPG3LGZGWTX5S2FSAH5
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7UAGESVQMAUSCYPG3LGZGWTX5S2FSAH5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ira Weiny <ira.weiny@intel.com> writes:

> On Tue, Jul 07, 2020 at 06:26:41AM +0530, Santosh Sivaraj wrote:
>> The default alignment for write-infoblock command is set to 2M. Change
>> that to use the platform's supported alignment or PAGE_SIZE. The first
>> supported alignment is taken as the default.
>> 
>> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
>> ---
>
> [snip]
>
>> @@ -1992,12 +2001,36 @@ static int namespace_rw_infoblock(struct ndctl_namespace *ndns,
>>  	const char *save;
>>  	const char *cmd = write ? "write-infoblock" : "read-infoblock";
>>  	const char *devname = ndctl_namespace_get_devname(ndns);
>> +	unsigned long long align;
>>  
>>  	if (ndctl_namespace_is_active(ndns)) {
>>  		pr_verbose("%s: %s enabled, must be disabled\n", cmd, devname);
>>  		return -EBUSY;
>>  	}
>>  
>> +	if (write) {
>> +		if (!param.align) {
>> +			align = ndctl_get_default_alignment(ndns);
>> +
>> +			if (asprintf((char **)&param.align, "%llu", align) < 0) {
>
> If we are looping through namespaces doesn't param.align need to be localized
> to this function as well?

Thanks for reviewing!

Right, I missed the "all" case. I will get that fixed this in v2.

Thanks,
Santosh

>
> Ira
>
>> +				rc = -EINVAL;
>> +				goto out;
>> +			}
>> +		}
>> +
>> +		if (param.size) {
>> +			unsigned long long size = parse_size64(param.size);
>> +			align = parse_size64(param.align);
>> +
>> +			if (align < ULLONG_MAX && !IS_ALIGNED(size, align)) {
>> +				error("--size=%s not aligned to %s\n", param.size,
>> +				      param.align);
>> +				rc = -EINVAL;
>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +
>>  	ndctl_namespace_set_raw_mode(ndns, 1);
>>  	rc = ndctl_namespace_enable(ndns);
>>  	if (rc < 0) {
>> @@ -2060,6 +2093,9 @@ static int do_xaction_namespace(const char *namespace,
>>  	}
>>  
>>  	if (action == ACTION_WRITE_INFOBLOCK && !namespace) {
>> +		if (!param.align)
>> +			param.align = "2M";
>> +
>>  		rc = file_write_infoblock(param.outfile);
>>  		if (rc >= 0)
>>  			(*processed)++;
>> -- 
>> 2.26.2
>> _______________________________________________
>> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
>> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
