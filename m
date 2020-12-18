Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633B2DDD2E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 04:10:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CABF100EB327;
	Thu, 17 Dec 2020 19:10:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A08F2100EB325
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 19:10:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b2so873500edm.3
        for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 19:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkEXl4qStkmYT3+mIwl6Q3Q3mHzuVuFn+pGe0fZurTg=;
        b=kAtNLYT7czydmG2yKG2/GUQcgugCOuv67CY2PquMXr8/J2nJRiSHtbHBCN23JLDI+W
         SxB7GDNx7G5LUQ4RD6svX1zxWbWadfPb8xIxF8pqZikVdVZUTCWgM+Ok3Pxy10Yh1XYD
         aOMAdCKu+mLPU4evb1gnQg7k3T71nSdVIJRlJsXUzcE4q3reyT4SY7fJsL/O7S5T33cO
         uwmlZwTYjrc2LqBdepjUfliTLXsdroHSu945lTcG16Q7hJPTbKkQVtAMu6n0B30PEf7Q
         lfn9yNx0K7yK/sVUcL6M5GlkxMo65NLuzYpBVOr7SnZqlTJF+aAVh9zf+ZZ8WrhwmDcw
         PYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkEXl4qStkmYT3+mIwl6Q3Q3mHzuVuFn+pGe0fZurTg=;
        b=m0LNDoaa/94affRfZSG6leRSsu0IcIFfhL8ptYbFgOuozdj7/9EgLoStktH6I2yDUG
         dcpitMHawttIRiz/LXotXNkeokv+RgdfLVo/S484vG+wLClatBza0jXQGeTZZFpEOW2W
         Mv2ZByZj2wben/daNNBFXTWG10EOU4M04YrhJqitWtX1VtpQtay6MQt8Z48uqIY872Gm
         Tqu/+uzYOsIVA28dD9x2TFtvOxrFonFGJlZ93MonlJDewpUHDznUB4ch3YkCBlsOgOAH
         20RZZxvf4Jd8UoH99LLOivETyUymRrFl6bSZF2SBA1e+YxN3KTTWZ+BUK6jxIi8aoJfL
         32xA==
X-Gm-Message-State: AOAM530r79og4qvrz/SbIGOR+wiPdZP7TIPbf/690iCB+/812G1bqA1p
	OS3ZJaShMbYi2Q/viSPrzki/n2Au4t47O46Buf4bbg==
X-Google-Smtp-Source: ABdhPJznkBnJXzOf7SdEY10Kh5oWG5k2t9apJPLinrpGixUO6+G+9aI+DGvwJptB+N0HUNXjeW+Tm8kH7KEVnFqM5k8=
X-Received: by 2002:a50:e0ce:: with SMTP id j14mr2471193edl.18.1608261014688;
 Thu, 17 Dec 2020 19:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20201120092251.2197-1-thunder.leizhen@huawei.com>
In-Reply-To: <20201120092251.2197-1-thunder.leizhen@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Dec 2020 19:10:04 -0800
Message-ID: <CAPcyv4jxgbawSbYF39g857fiDCRmMACr1u-OiSWkz4M0+2UPbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] device-dax: avoid an unnecessary check in alloc_dev_dax_range()
To: Zhen Lei <thunder.leizhen@huawei.com>
Message-ID-Hash: P5YSWXERO4MQBHTXQOX7ADCL4YCOQEKU
X-Message-ID-Hash: P5YSWXERO4MQBHTXQOX7ADCL4YCOQEKU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P5YSWXERO4MQBHTXQOX7ADCL4YCOQEKU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 20, 2020 at 1:23 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Swap the calling sequence of krealloc() and __request_region(), call the
> latter first. In this way, the value of dev_dax->nr_range does not need to
> be considered when __request_region() failed.

This looks ok, but I think I want to see another cleanup go in first
before this to add a helper for trimming the last range off the set of
ranges:

static void dev_dax_trim_range(struct dev_dax *dev_dax)
{
        int i = dev_dax->nr_range - 1;
        struct range *range = &dev_dax->ranges[i].range;
        struct dax_region *dax_region = dev_dax->region;

        dev_dbg(dev, "delete range[%d]: %#llx:%#llx\n", i,
                (unsigned long long)range->start,
                (unsigned long long)range->end);

        __release_region(&dax_region->res, range->start, range_len(range));
        if (--dev_dax->nr_range == 0) {
                kfree(dev_dax->ranges);
                dev_dax->ranges = NULL;
        }
}

Care to do a lead in patch with that cleanup, then do this one?

I think that might also cleanup a memory leak report from Jane in
addition to not needing the "goto" as well.

http://lore.kernel.org/r/c8a8a260-34c6-dbfc-1f19-25c23d01cb45@oracle.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
