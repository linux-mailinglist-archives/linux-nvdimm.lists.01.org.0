Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AA5117165
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Dec 2019 17:21:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5B4F1011330B;
	Mon,  9 Dec 2019 08:24:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=openosd@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EC38B100DC2DC
	for <linux-nvdimm@lists.01.org>; Mon,  9 Dec 2019 08:23:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f4so254655wmj.1
        for <linux-nvdimm@lists.01.org>; Mon, 09 Dec 2019 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WBIobri3MkGop/QDs53NXiO6RTUjcrDu0iF/QcG86H0=;
        b=W4rrS4w8J3X0s/knW10xoM7c0XvfkfBWKTpkJv7UBseXclDelL+x9rXP7Toz7IePVV
         E5JzmhHlqkJIHH5mn99dwLDDvtuUF32qwp1jcmmbOYO9Vx9Xa51TZUx2qhVksqgzSF6C
         vkuu8dAlkddPpEADOrxVKmHQ8zrhfZi7ak47Vhg/Xektz7G4ICP9gHMA3onOstOx7DA8
         Gbg3tBaeCRW879E08AF9uT1GP73T9Ro8s3Y5q2RwoPXHxALwKbg8mPZvvVOvtkaY33PM
         /R7quTP54GV5ANZbI5Gh2bNUwoRz/CGy5lW2XqUhfKuy0D60x5FGxD8kfBmIVJPI5Vl9
         3eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WBIobri3MkGop/QDs53NXiO6RTUjcrDu0iF/QcG86H0=;
        b=oAfr026eNyhuKTaY4/e4n19uBAovkVnO5D3c5yz1JLSCXP0y+VLgNuoreWt154LKx8
         vhX6fQ46jJcW9Fskh8DX3xwH1q/1EmTOP58kyPl9MOTPzKAuXyWkDveTu7kHo1HzB0OH
         0sP2YFTKA1a07epYJHXK4ZBzr8c0r1zsMVdNLm8hbQQLJspMs4/hWX2TM9MGFPYSMhN7
         eQrrFpntQYRZObVfNxFMuHydZR7QxOzd2ekmm2HDFW/6gv5roLCZBBUZZrdaRIjAUy/0
         mXORBcKlaCVz93MdglehW1Il1kMSMbYMOyz5PT1ERDuX0+56U09Zg973dir3cStMiiOg
         46bQ==
X-Gm-Message-State: APjAAAU5msq1z58ECzaFc7ASvXfh/mqTtpFAPL/H2aMKPfEI2xAhvuwc
	88a+xdiyYVsECZoqi6VKDjT+JRTj
X-Google-Smtp-Source: APXvYqyL3Ao5jyCATnxdfctwvZ3CBAbBWb4P4ED0mJcOmAm4L1BkpLHWjA2CTQz7JIP995Or8WFlMA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr25766920wmj.96.1575908427479;
        Mon, 09 Dec 2019 08:20:27 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.gmail.com with ESMTPSA id n10sm27650061wrt.14.2019.12.09.08.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:20:26 -0800 (PST)
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] The end of the DAX experiment
To: Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>
References: <CAPcyv4jyCDJTpGZB6qVX7_FiaxJfDzWA1cw8dfPjHM2j3j3yqQ@mail.gmail.com>
 <20190214134622.GG4525@dhcp22.suse.cz>
 <CAPcyv4gxFKBQ9eVdn+pNEzBXRfw6Qwfmu21H2i5uj-PyFmRAGQ@mail.gmail.com>
From: Boaz Harrosh <openosd@gmail.com>
Message-ID: <5a45a763-d060-7cb1-9772-dd6e9f5f868a@gmail.com>
Date: Mon, 9 Dec 2019 18:20:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gxFKBQ9eVdn+pNEzBXRfw6Qwfmu21H2i5uj-PyFmRAGQ@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: NNWPCEAU32JFSHI4YSHAIXX7ZWBGHKH4
X-Message-ID-Hash: NNWPCEAU32JFSHI4YSHAIXX7ZWBGHKH4
X-MailFrom: openosd@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: lsf-pc@lists.linux-foundation.org, linux-xfs <linux-xfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NNWPCEAU32JFSHI4YSHAIXX7ZWBGHKH4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/02/2019 20:25, Dan Williams wrote:
> On Thu, Feb 14, 2019 at 5:46 AM Michal Hocko <mhocko@kernel.org> wrote:
>>
>> On Wed 06-02-19 13:12:59, Dan Williams wrote:
>> [...]
>>> * Userfaultfd for file-backed mappings and DAX
>>
>> I assume that other topics are meant to be FS track but this one is MM,
>> right?
> 
> Yes, but I think it is the lowest priority of all the noted sub-topics
> in this proposal. The DAX-reflink discussion, where a given
> physical-page may need to be mapped into multiple inodes at different
> offsets, might be more fruitful to have as a joint discussion with MM.
> 

This topic is very interesting to me.
In current ZUFS implementation we support this option for a long time.

IE: Map same pte_t into different indexes of the same file-mappings as well as
in vma(s) of different files, at different indexes. Including invalidation
of mapping of a pwrite into such a shared page.
(A write to a shared block will allocate a new block for writing)

This effort off-course involves the participation of the FileSystem
to give a list of files and indexes for map_unmapping().
I can explain if you want how we did this.

Cheers
Boaz
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
