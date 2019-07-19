Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2A66EABA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Jul 2019 20:36:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3C2F7212D2775;
	Fri, 19 Jul 2019 11:39:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 935352194EB78
 for <linux-nvdimm@lists.01.org>; Fri, 19 Jul 2019 11:39:17 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w196so3661957oie.7
 for <linux-nvdimm@lists.01.org>; Fri, 19 Jul 2019 11:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rNTxjf4zgIZ3AfRSHrsW6V4xcIsbx9fKTjIydqQ84y4=;
 b=UsfMSQxEG1b1/dl0kK/B2g9mEYs7mJdokNiGHZeVjw/jkvscB0EwyrMW66PTWfE64U
 TftE23chjipBkJSX3b38XjEEyak81gIk6aXJiN9KTPrZVKZG3y2XlsYAoyUyPg3YnLt5
 LyLaSFzc8WrDK0XTja9qlvWwbfu2xFEMDlSlcv1lULMs58kMAdGtkiPFobXZ99gVRMNt
 Ycw6McM3egCZjFUVx8XZMMEfTDcmgbeDDZHInDvNR4Wc2JASXAKu7ORwVV1lI9nEwnQW
 YLA1aZuzyrpzBXXfmVRf8qOhJyLpGsNrgZzBvjSdJx3rt/JSn6BxnD/dddFQzt0f1dM/
 BaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rNTxjf4zgIZ3AfRSHrsW6V4xcIsbx9fKTjIydqQ84y4=;
 b=j5LhPBDHqzD6LQZ27wbhqCvk76/PheA+ghiOYXwgU0SEJySvfC0gF0Zz2OU4qrwEnd
 n3JeF0QHpYMUJ9uQdhMEOaGriIo7/ZCnDlx+hptQjlaj7SLwH+gJg+1eRg95SMy8YX68
 2lN4PAY2h93qnb8N317kENjZz3jmJe0ctJVMRMTq6lrUotB5l0dx5BAgO0vX4xWnXorO
 b3/JhTjk3u1/eYv1jwzLDkyogt3efLt/536WhKskIg927AaKvBcq/uDwKWATOB17u2LW
 6LXidzFMT7waSOpIa98IxrG9wJw/HCDPn4BHGQ1Wq3vNVxxVs0IRtal/IAiVit0VhyOI
 i86g==
X-Gm-Message-State: APjAAAVDLTSZQ6+Q1avWQh/smhj5uVd4+BpgCOmMR/Mhd0ok/wfMa4xa
 7eTl6drRm0Vw8M/x3uL/qDLJQbRxDVrcLAT6OyphPQ==
X-Google-Smtp-Source: APXvYqykffKgFrQb/1rls3hqzXMsX5m4AT2E/Q+hWmzWe8/pERcpRDiW4UPmSzb1hmAI4B2vGb9KMGrbYLqh/GbNLns=
X-Received: by 2002:aca:1304:: with SMTP id e4mr26619144oii.149.1563561409220; 
 Fri, 19 Jul 2019 11:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-6-vishal.l.verma@intel.com>
 <CAPcyv4jeVMQP8QAtiQt81n1+jS7J49L8Ki_GDtT6rXFmaxMogQ@mail.gmail.com>
 <b86f69b2b0e7b3f3755c64f7a4310161dc8389dc.camel@intel.com>
In-Reply-To: <b86f69b2b0e7b3f3755c64f7a4310161dc8389dc.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Jul 2019 11:36:37 -0700
Message-ID: <CAPcyv4jimtN+70iJD1EeZVkuX7udUEnfCM-stEiXvsWtknaTPg@mail.gmail.com>
Subject: Re: [ndctl PATCH v6 05/13] daxctl/list: add target_node for device
 listings
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jul 19, 2019 at 11:08 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Thu, 2019-07-18 at 16:41 -0700, Dan Williams wrote:
> > On Wed, Jul 17, 2019 at 3:54 PM Vishal Verma <vishal.l.verma@intel.com
> > > wrote:
> > >
> > > @@ -284,6 +285,13 @@ struct json_object
> > > *util_daxctl_dev_to_json(struct daxctl_dev *dev,
> > >         if (jobj)
> > >                 json_object_object_add(jdev, "size", jobj);
> > >
> > > +       node = daxctl_dev_get_target_node(dev);
> > > +       if (node >= 0) {
> > > +               jobj = json_object_new_int(node);
> > > +               if (jobj)
> > > +                       json_object_object_add(jdev, "target_node",
> > > jobj);
> > > +       }
> > > +
> >
> > We moved 'numa_node' to the UTIL_JSON_VERBOSE set on "ndctl list"
> > should do the same for target node?
>
> Hm, true. Arguably, the target_node is much more pertinent in system-ram
> mode, and /should/ be in the default verbosity?
>
> One option could be to make it always show if the mode is system-ram,
> but not otherwise - but I don't know if that would cause more confusion
> as an attribute might seem to magically appear or disappear with the
> same command options..
>
> Yet another option is, the output right after daxctl-reconfigure-device
> always sets UTIL_JSON_VERBOSE, but for daxctl-list, it is only done if
> the user supplies it.
>
> Any preferences on which way to go?

'verbose after reconfigure' sounds good, but you're right, it's more
pertinent in the device-dax case, especially when that might be one of
our only identification mechanisms for non-NFIT device-dax. So I'm ok
to keep it as is on second thought.
>
> Thanks,
> -Vishal
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
