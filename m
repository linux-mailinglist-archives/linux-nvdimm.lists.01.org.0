Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0337828AD5B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 06:51:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 106FD158AFE91;
	Sun, 11 Oct 2020 21:51:20 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6A3D1158AFE8E
	for <linux-nvdimm@lists.01.org>; Sun, 11 Oct 2020 21:51:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o3so3112215pgr.11
        for <linux-nvdimm@lists.01.org>; Sun, 11 Oct 2020 21:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=MFSt4wsGHuW3F3ORtsjZB1lmBt34CEUDyR8ln68K7X4=;
        b=TWc1rSFyiIBrlO6TJpX7i5avreepo4i9MCoTUoX2FhGOPSSEaFb3pcqY7m8INC8I60
         1d+JOwyTacRH46m2KgPaQhQyEOzQ08zpDWo4tSx3jWmBsxKPK3au81a8nyeD/RqOvYek
         0Zwlg68zaXTOGpeECn1GSNkXEdQiVBjCFR728M7L2GHDzHEsZlwV97GUFftniaT5UZBA
         e3RmJNr2EykF7ajTCLN34um59Hg4Wl1cA4VP9B2yngLT9fYt4gc1gMbxTVBtSDXxdlmm
         Uz8lEOkiWG6Rm3ggJP71sFrU463PhlPtiOCWou6OV/y3JnRrl0Z0IhMykiJBvu2puwdL
         jjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MFSt4wsGHuW3F3ORtsjZB1lmBt34CEUDyR8ln68K7X4=;
        b=QbrZlTr7uB334LvH9a5IoJUtOQyw3Hege3U+QkkjbWglB8E1JNRfjul51eQcFpJvC0
         m0hoxTqdWp1JXFTHBbNAUB3LpzzKFd2GFbkyIjHJx5zSwEJxS0QjCk4UFh7AioHv77eT
         /9QvzMdOhUjZiSMMW3IJK6z5FPtjVhSzMSCmy970mHTOwEwBonfrMJmdISMirLVgUoa/
         PuxKIKs7KY6GMI1fiCRMVYI7Y4jSK4NY7t8UUCdVr++eRb9UH49x6IYHKr8PgPiXRKwz
         lbuv5i6LN0rezHFkQGWTk1QwZFNNm/YcHxbum6Xqg7F4v6DyYliHxcjSB41dvAcnETsl
         QOqA==
X-Gm-Message-State: AOAM531nqxtLZaROPFhMgwcSfnmq3dw6pVroMFyEFUlTYu+KGInpTSXb
	SJa83RTMIBymdePh96Iaj7+Pag==
X-Google-Smtp-Source: ABdhPJybB3jv1MzNOwX5IWWkeanUaj4nSqoPa0neJlvQxhyMCAUBc7pPNoy9quht6RVbkla9asdPmQ==
X-Received: by 2002:a17:90b:3649:: with SMTP id nh9mr18096298pjb.123.1602478277484;
        Sun, 11 Oct 2020 21:51:17 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id f21sm1020377pfn.173.2020.10.11.21.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 21:51:16 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, Dan Williams
 <dan.j.williams@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] libndctl: Fix probe of non-nfit nvdimms
In-Reply-To: <87pn5qy8vb.fsf@vajain21.in.ibm.com>
References: <20201009120009.243108-1-vaibhav@linux.ibm.com>
 <145db3d86fa6bddf55c0e7c4aa149984676cd723.camel@intel.com>
 <CAPcyv4j89a_Nevq1y92UPGedm74VUYCunkf62T5S3UeXzW6vKg@mail.gmail.com>
 <87pn5qy8vb.fsf@vajain21.in.ibm.com>
Date: Mon, 12 Oct 2020 10:21:14 +0530
Message-ID: <87v9fg3v3x.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: KZ2MT55IVTPB2PXXXYNJCGIZ24NGAKPW
X-Message-ID-Hash: KZ2MT55IVTPB2PXXXYNJCGIZ24NGAKPW
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KZ2MT55IVTPB2PXXXYNJCGIZ24NGAKPW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vaibhav Jain <vaibhav@linux.ibm.com> writes:

> Hi Dan and Vishal,
>
> Thanks so much for quick turnaround on this.
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
>> On Fri, Oct 9, 2020 at 11:36 AM Verma, Vishal L
>> <vishal.l.verma@intel.com> wrote:
>>>
>>> On Fri, 2020-10-09 at 17:30 +0530, Vaibhav Jain wrote:
>>> > commit 107a24ff429f ("ndctl/list: Add firmware activation
>>> > enumeration") introduced changes in add_dimm() to enumerate the status
>>> > of firmware activation. However a branch added in that commit broke
>>> > the probe for non-nfit nvdimms like one provided by papr-scm. This
>>> > cause an error reported when listing namespaces like below:
>>> >
>>> > $ sudo ndctl list
>>> > libndctl: add_dimm: nmem0: probe failed: No such device
>>> > libndctl: __sysfs_device_parse: nmem0: add_dev() failed
>>> >
>>> > Do a fix for this by removing the offending branch in the add_dimm()
>>> > patch. This continues the flow of add_dimm() probe even if the nfit is
>>> > not detected on the associated bus.
>>> >
>>> > Fixes: 107a24ff429fa("ndctl/list: Add firmware activation enumeration")
>>> > Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>>> > ---
>>> >  ndctl/lib/libndctl.c | 3 ---
>>> >  1 file changed, 3 deletions(-)
>>>
>>> Ah apologies - this snuck in when I reflowed Dan's patches on top of the
>>> papr work for v70.
> No worries :-)
>
>>>
>>> I expect you'd like a point release with this fix asap?
> Yes, that will be great. Thanks
>
>>>
>>> Is there a way for me to incorporate some papr unit tests into my
>>> release workflow so I can avoid breaking things like this again?
>>>
>>> I'll also try to do a better job of pushing things out to the pending
>>> branch more frequently so if you're monitoring that branch, hopefully
>>> things like this will get caught before a release happens :)
>
> Fully agree, if that happens we can incorporate it into our CI system to
> ensure that such regressions are caught early on before any release is
> tagged.
>
>>
>> Would be nice to have something like a papr_test next to nfit_test for
>> such regression testing. These kinds of mistakes are really only
>> avoidable with regression tests.
> Yes Agree, fortunatly Santosh  has recently posted an RFC patchset
> implementing such tests at [1]. Once that gets merged, can used to
> perform regression testing.
>
> [1] "testing/nvdimm: Add test module for non-nfit platforms"
> https://lore.kernel.org/linux-nvdimm/20201006010013.848302-1-santosh@fossix.org/
>

Thanks Vaibhav to point that out.

Dan/Vishal/Ira,

If you could provide your comments on the above RFC we could move forward on
this.

Thanks,
Santosh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
