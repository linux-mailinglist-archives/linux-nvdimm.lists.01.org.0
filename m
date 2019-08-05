Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06638256D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  5 Aug 2019 21:16:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B78BE2130D7E0;
	Mon,  5 Aug 2019 12:19:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=boaz@plexistor.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B92D82130A4E1
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 12:19:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s15so52725400wmj.3
 for <linux-nvdimm@lists.01.org>; Mon, 05 Aug 2019 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=plexistor-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i8MUAFs9xWo3DeulQdVmEqj8r8vwJULZDf6MNUFq2ww=;
 b=UrVz3TL4y2Wd+2usgnHy3ExsuaOYfeNXBdmadp57B6j14Ve7GM/RifZdIa0BVHr1mR
 7EkSWqmNTRYWs8nNOfXbwW3zYaSffpmhx5FrOADWtrlzKsbxRmJQ56JPTmj4odOuuhcf
 GtyYiWudoTtgCmBg9n/4fgOB2kFttMVVvMsGFsI26QLy91SItBSIbfzaDnAQv3BwLj6U
 gWkJ8YpDvcU1ASeinejR8VSX6IjC07krSj47vZQWeEbbAqR2hO9cQfZwOzMLsqQo7ClK
 y/i3avrc0nF4z4Hp82ZrkJ56foE4TgFoWLOynsKwpfZFZ4E1XiAqKSR08yPeMsCWU6dU
 LM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i8MUAFs9xWo3DeulQdVmEqj8r8vwJULZDf6MNUFq2ww=;
 b=d9WGzD2lLJ5p+40gYg0neM2+LkWtzLJC9J1ZGq7pS0Rx9Gdjifmjtn3+Zv2bgDWmxd
 aqb+FUgBz3DJaoY6z9eds/KDoxp2lrR5xTrttucvTC5m46lJ5Fm4fepV0rD6ufpdQPRs
 3Tmt2Q09eOyUK6DBYk8ixjV06XLqXxxoP90mg/APiN9rzrxDSHB/RrCrEN9Azyhbezi5
 qehVOqrndMNxQr57SPCJOi5YnBw/9GXgIoUkwfTGKq9T7D8O8sm07/gU5zaUpBuoQS+s
 bh3AmROHwQ12F/bJN7zckym7EEQjZTqB9pPyqg8njTkzQEjhuApGNNX/1E8XeqYKy0Jl
 1uZA==
X-Gm-Message-State: APjAAAXDIbIYsNWEYuRWUgeWcwHygsTk4KXyfS2IU4EQEZNOImjLO5HG
 ln6pLh2CyvBKte+3jQXQe4Y=
X-Google-Smtp-Source: APXvYqyg2z6e5NAOZET2e8ipXtjRjnPZ9wpiF9eF9YkoNugyrx+Do8m6yVMVw8QMotm5Qi7zqcbHQg==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr20340165wmk.88.1565032609390; 
 Mon, 05 Aug 2019 12:16:49 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
 by smtp.googlemail.com with ESMTPSA id b186sm66079447wmb.3.2019.08.05.12.16.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 12:16:48 -0700 (PDT)
Subject: Re: [PATCH] dax: dax_layout_busy_page() should not unmap cow pages
To: Vivek Goyal <vgoyal@redhat.com>, Boaz Harrosh <boaz@plexistor.com>
References: <20190802192956.GA3032@redhat.com>
 <CAPcyv4jxknEGq9FzGpsMJ6E7jC51d1W9KbNg4HX6Cj6vqt7dqg@mail.gmail.com>
 <9678e812-08c1-fab7-f358-eaf123af14e5@plexistor.com>
 <20190805184951.GC13994@redhat.com>
From: Boaz Harrosh <boaz@plexistor.com>
Message-ID: <9c0ec951-01e7-7ae0-2d69-1b26f3450d65@plexistor.com>
Date: Mon, 5 Aug 2019 22:16:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190805184951.GC13994@redhat.com>
Content-Language: en-MW
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, virtio-fs@redhat.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 05/08/2019 21:49, Vivek Goyal wrote:
> On Mon, Aug 05, 2019 at 02:53:06PM +0300, Boaz Harrosh wrote:
<>
>> So as I understand the man page:
>> fallocate(FL_PUNCH_HOLE); means user is asking to get rid also of COW pages.
>> On the other way fallocate(FL_ZERO_RANGE) only the pmem portion is zeroed and COW (private pages) stays
> 
> I tested fallocate(FL_PUNCH_HOLE) on xfs (non-dax) and it does not seem to
> get rid of COW pages and my test case still can read the data it wrote
> in private pages.
> 

It seems you are right and I am wrong. This is what the Kernel code has to say about it:

	/*
	 * Unlike in truncate_pagecache, unmap_mapping_range is called only
	 * once (before truncating pagecache), and without "even_cows" flag:
	 * hole-punching should not remove private COWed pages from the hole.
	 */

For me this is confusing but that is what it is. So remove private COWed pages
is only done when we do an setattr(ATTR_SIZE).

>>
>> Just saying I have not followed the above code path
>> (We should have an xfstest for this?)
> 
> I don't know either. It indeed is interesting to figure out what's the
> expected behavior with fallocate() and truncate() for COW pages and cover
> that using xfstest (if not already done).
> 

I could not find any test for the COW positive FL_PUNCH_HOLE (I have that bug)
could be nice to make one, and let FSs like mine fail.
Any way very nice catch.

> 
> Thanks
> Vivek
> 

Thanks
Boaz
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
