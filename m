Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284AC20F65C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 15:54:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 720A911427DB4;
	Tue, 30 Jun 2020 06:54:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=axboe@kernel.dk; receiver=<UNKNOWN> 
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 197E511427DB3
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 06:54:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so9212755pje.4
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hKI90P9PUUShWQ5+4wQBc7xPIwXEAfQYKEsGh1MpJZs=;
        b=DTpxaxoBrlqgFtIm8yAQMb341OyK/ndjEYjXK9tGbhGBwisW4MOxBHZ4AF4FDA/02m
         FE1IEvNVNRcPVI4EfkzNjyzKc28vzwvcAXCPa48q88z6AfYJyEqtZavoB08GtaqwIFmZ
         5msOaC6bHwT4f6NJcL2N48MYAird2/Xlj5iei4yfkZKl2Jgrru0q2OyYJkjRAMbDQ2kB
         VDXDrxP8KF6sFSMpn3AGotfAimtzX2YLcVXjs0JutM1wEqD7nRFwq0bLMjlwHPYp5odZ
         e+66w2vtmERdrhz2mTHMd0mWQ0ZRTEcZzcd3acmnQYyNunRekXJ4MMVmPw5lJJ2ybCJv
         oP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKI90P9PUUShWQ5+4wQBc7xPIwXEAfQYKEsGh1MpJZs=;
        b=BWLAGQ6Rr6LwuratEdf03vYtZusPwdwGnJjcKSW/auknM7F7aFzWGYnKFwuUgBwUjE
         qwJoPr8waDMFMIBHEuqG8n3CwxoihF9ye2UH9lzRwnzy2Nx0drZdbnqZsHyB59vcG99w
         ly+n/JjqsfP4s0ytT4fZCFHiIXM6HYC/0Gd4KO6AeI4ulAn4xe0xLHHpI4hMMNHT3hfi
         k3TY0qRH4EpK2HBPqyky38ULvaXjgyKbNefiS4t8G3/EBzNfxvSd6ofCqv+LYniz02lv
         2/12IrF4a9NCGqPJv9pu7ae63nGySlrL0rYnWYgGJhjEOTFIjZl2JUoOfJWlGQhU48wb
         1YHg==
X-Gm-Message-State: AOAM533j3t8hhwzv625ruqB093F48i1VZ4SjPY3m/oMZ1zsOy6rZxfFQ
	wdbTttvKIyxwqSC2sbUMpR+5vQ==
X-Google-Smtp-Source: ABdhPJyz40Dk+a8U1c/CjzUO1QAZkxXoTvB1Z5x2Pa5jkubAyLo6SdeOcTzcPuLBVyj9atcxDTr0Bg==
X-Received: by 2002:a17:902:ff0c:: with SMTP id f12mr18122209plj.254.1593525289171;
        Tue, 30 Jun 2020 06:54:49 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b? ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id l12sm2722675pff.212.2020.06.30.06.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:54:48 -0700 (PDT)
Subject: Re: [PATCH 11/20] fs: remove a weird comment in submit_bh_wbc
To: Christoph Hellwig <hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
 <20200629193947.2705954-12-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <70e8de25-4e26-9c00-1492-e433ebfdbc90@kernel.dk>
Date: Tue, 30 Jun 2020 07:54:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629193947.2705954-12-hch@lst.de>
Content-Language: en-US
Message-ID-Hash: GUANYWVZRMVZHCC4C7GDPK4MG2MWQPC4
X-Message-ID-Hash: GUANYWVZRMVZHCC4C7GDPK4MG2MWQPC4
X-MailFrom: axboe@kernel.dk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GUANYWVZRMVZHCC4C7GDPK4MG2MWQPC4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> All bios can get remapped if submitted to partitions.  No need to
> comment on that.

I'm pretty sure that comment is from me, dating back to when the bio
code was introduced in 2001. The point wasn't the remapping, just
that from here on down the IO was purely bio based, not buffer_heads.
Anyway, totally agree that it should just die, it's not that
interesting or useful anymore.

-- 
Jens Axboe
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
