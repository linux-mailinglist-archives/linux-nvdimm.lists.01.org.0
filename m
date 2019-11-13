Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CFAFAA13
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Nov 2019 07:14:22 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1927A100DC420;
	Tue, 12 Nov 2019 22:16:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C8D86100DC41C
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 22:15:58 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b16so639285otk.9
        for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 22:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8/eBOEFYWm/dQgNr/pNtbBC73p9IYMi5gGkpqo2SI4=;
        b=hJ6RPPBE1NoZf0/QVupYvy9OSDziN9tXHIJgPesa3XQzwUekMxqHmy4ywWzJ7olyYn
         S25aiGORN3SKrmbL/zg3J82nKwwPyIlH7PmQWbCLsU8YVru2546iAwoNbriXDphYCHP3
         MpbJ6zeFfdnFYRNFEWoBo/jpLeE7M5vPyoMOZssjrCd54wlf2SAg74J9p7QSN2Rc3HbZ
         dxBhLBVLxCENTG/wdo2QS9QsWhp6iAHjPsEyxbnLxnN4Zf7etAvI1IsZWkGfHlLFA659
         krN85FOxSocMTjuEy7YL4rUwZsNs9tYal7YQEvS3BOcZKt5J7hBKVU3FLEUJVZFKERpY
         75eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8/eBOEFYWm/dQgNr/pNtbBC73p9IYMi5gGkpqo2SI4=;
        b=m3b8bDt+As8xaWEjeLlUN6/AQWlmXEK3FuIQrrkhBqqleg739Vgb6tRHs9cvRKGmP4
         sv0ttIAzkQexgR+jVH1wxjqA8PR87zmGU7XjYDrOGitfAudamm3h6exRTjhq07szhVNR
         k/72NBRJmIAg79TLlmx+TT/+cezUMomaTM9ZywisWrzKFQGxbALiAg3muLaxGuo36XYa
         pEmSvlItawm7Nh5gVq1d7N1FW+o6znIdkUB05lXX1sznENxUR8Yx/yE8ZIakyA2xUywd
         UdT03NuJlF5KEU9pc7vH22jLT39Z5ukeoQMDDd4K+yfcXFVpKn6zrQH3UDTHp22VLbN3
         4rCQ==
X-Gm-Message-State: APjAAAVWf0SM/g6eFTAuoU2VGgCZu5XVv5kk1cYHT28+P1inEHLEFKoM
	ar4/nvySVYGW4VylHex+ic6ruW3tx2zwP1splvNVzw==
X-Google-Smtp-Source: APXvYqydyDDmkM3Pb1e2pPbf9fbI2BGEVuN/kDhx0lcoQbUla4YO7+zpV4A7M6u65IKIch5dF7aZebIgX7kFjMgndhw=
X-Received: by 2002:a05:6830:1b70:: with SMTP id d16mr1213448ote.71.1573625656497;
 Tue, 12 Nov 2019 22:14:16 -0800 (PST)
MIME-Version: 1.0
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157309901655.1582359.18126990555058555754.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87h839tpo9.fsf@linux.ibm.com> <CAPcyv4gTRiZuA8A7cDxCZtHJv=LZMjd=tVgq35gbc0K8BUDHsA@mail.gmail.com>
 <738e328b-9a9b-b297-8379-f0d72d06c5c9@linux.ibm.com>
In-Reply-To: <738e328b-9a9b-b297-8379-f0d72d06c5c9@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Nov 2019 22:14:04 -0800
Message-ID: <CAPcyv4iB1r7FAYEm_+vtj_BGS1k6Cu_2xG7tH9O601zrk2wNXw@mail.gmail.com>
Subject: Re: [PATCH 04/16] libnvdimm: Move nd_numa_attribute_group to device_type
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: GH2M7HB6OKZCH4GOSAHC7ZDURCOCLVVR
X-Message-ID-Hash: GH2M7HB6OKZCH4GOSAHC7ZDURCOCLVVR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GH2M7HB6OKZCH4GOSAHC7ZDURCOCLVVR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 12, 2019 at 10:02 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 11/13/19 6:56 AM, Dan Williams wrote:
> > On Tue, Nov 12, 2019 at 1:23 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >>> A 'struct device_type' instance can carry default attributes for the
> >>> device. Use this facility to remove the export of
> >>> nd_numa_attribute_group and put the responsibility on the core rather
> >>> than leaf implementations to define this attribute.
> >>>
> >>> Cc: Ira Weiny <ira.weiny@intel.com>
> >>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> >>> Cc: Vishal Verma <vishal.l.verma@intel.com>
> >>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>
> >>
> >> can we also expose target_node in a similar way? This allows application
> >> to better understand the node locality of the SCM device.
> >
> > It is already exported for device-dax instances. See
> > DEVICE_ATTR_RO(target_node) in drivers/dax/bus.c. I did not see a use
> > case for it to be exported for other nvdimm device types.
> >
>
> some applications do want to access the fsdax namspace as different
> mount points based on numa affinity. If can differentiate the two
> regions with different target_node and same numa_node, that will help
> them better isolate these mounts.

Can you be more explicit than "some", and what's the impact if the
kernel continues with the status quo and does not export this data?
I'm trying to come up with the justification to include into the
changelog that adds that information.

At least on the pmem platforms I am working with the pmem ranges with
different target nodes also appear on different numa nodes so there is
no incremental benefit for target node there.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
