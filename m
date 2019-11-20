Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13652103239
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Nov 2019 04:46:49 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C55A100DC3D1;
	Tue, 19 Nov 2019 19:47:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 751A2100DC3CF
	for <linux-nvdimm@lists.01.org>; Tue, 19 Nov 2019 19:47:30 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d5so19987373otp.4
        for <linux-nvdimm@lists.01.org>; Tue, 19 Nov 2019 19:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qnLjkAQvsDWjadsTnrIPLiPzwT4BVVRmoZBHUtE63M=;
        b=nqvgh4pkFJrULBILgmm4jLkZM4n9K4lvU1sF9KX4nvAQW8FI0K7xCHfyqnidJJK+Kn
         Mz8O1miZgT0lUDfwwM50xMYAuKiukJCeu7hKmv53waJwKrmTghMM0s6iyfLYYb/eftIN
         ei5EkF+WlEg5NUlacpgv00l91/rwg9S36kupwKlmbaC2AXy/nt0YM574UVOEAXIzNMRJ
         XS9CMoEU7RLyXqyHLDDfu/el5BhcbTmW7DmMj1gsOiUzWaQJ/Jcn1UeAKNqleMleLHQd
         YLDsmd7bbKDXsfYhYiCupVrjvNXLi6Aj0rtbThS/aKjBaInbPvFiej1G48F3qauZFjZx
         v8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qnLjkAQvsDWjadsTnrIPLiPzwT4BVVRmoZBHUtE63M=;
        b=NUpECYd77dXiiLUXOs+9T6LqzKadiD2VbuVV0C+BQgv91Z7GD1dBLKmM8tU1+XKQQX
         2t9WvdSj/m+sR8AbMbsoP82bxaTjuKd1yvUoyVqvvU99EbDgGUXKvKk2OmKC3LxLl+eB
         7bIdZkILVjpikObemFO9S9HqKDkdA2OrXbB5H08Fc2oq5j4wgkv1PIJEX3UCrvD/yPka
         dWXF7f594p7sc45y3wjeOw0bWAj2EqFLI43r6lMBXHBR05TnwO+PKPKxOIPLb6G4TDcs
         1oUtG4MdCEKu6ksiyN1UOAcuytvR4BgsJwkWGShOyxZ7D9tL6KG4As8nUlaf7yuU9a3z
         I2qQ==
X-Gm-Message-State: APjAAAVMtH+p/HYGcdL7V/aJ+rMmAVvtdq1QKIk8aOgTE1c347EaKW7R
	SePX97SK6ZmBmsAnvUGJnGO2SvYfi0wFRju/GDqiNA==
X-Google-Smtp-Source: APXvYqwuEnjwj3Y53BLmq0qAZHHKArCZir8aQLMD50GiTMGTDqSHrw0JdA8bRbYsPfTf8sGoem5BHXLNz40Bbjc0ysI=
X-Received: by 2002:a05:6830:1b70:: with SMTP id d16mr277226ote.71.1574221603278;
 Tue, 19 Nov 2019 19:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20191028094825.21448-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4gZ=wKzwscu_nch8VUtNTHusKzjmMhYZWo+Se=BPO9q8g@mail.gmail.com>
 <6f85f4af-788d-aaef-db64-ab8d3faf6b1b@linux.ibm.com> <CAPcyv4gMnSe26QfSBABx0zj3XuFqy=K1XaGnmE3h3sP3Y76nRw@mail.gmail.com>
 <4c6e5743-663e-853b-2203-15c809965965@linux.ibm.com> <CAPcyv4h42_1deZDaaW1RqX0Ls+maiFO_1e=6xJuHTa3wdWvVvA@mail.gmail.com>
 <87o8xp5lo9.fsf@linux.ibm.com> <8736eohva1.fsf@linux.ibm.com>
 <CAPcyv4hroohsrXT1YHQB-L8ZFa2kUW+bKy03We4Mt7afeJgu3Q@mail.gmail.com>
 <87o8x9h5qa.fsf@linux.ibm.com> <CAPcyv4gv52NK4+=3wcJ2uKX7xnaYVaF-H6O-XfJK8MiRX60SBg@mail.gmail.com>
 <7e9a19c1-992f-a92a-172d-bcbad1298c41@linux.ibm.com>
In-Reply-To: <7e9a19c1-992f-a92a-172d-bcbad1298c41@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 19 Nov 2019 19:46:31 -0800
Message-ID: <CAPcyv4hTVqdj9_8SYfkeohiQYuvRPf1MA7dvFmC8GqV1y4tN5w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libnvdimm/namespace: Make namespace size
 validation arch dependent
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: R7KKTXRBNG6QLAGHBFJICBM4J645UX6I
X-Message-ID-Hash: R7KKTXRBNG6QLAGHBFJICBM4J645UX6I
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R7KKTXRBNG6QLAGHBFJICBM4J645UX6I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 19, 2019 at 7:19 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 11/19/19 11:28 PM, Dan Williams wrote:
> > On Mon, Nov 18, 2019 at 1:52 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> Dan Williams <dan.j.williams@intel.com> writes:
> >>
> >>> On Sat, Nov 16, 2019 at 4:15 AM Aneesh Kumar K.V
> >>> <aneesh.kumar@linux.ibm.com> wrote:
> >>>>
> >>
> >> ....
> >>
> >>
> >>>>
> >>>> Considering the direct-map map size is not going to be user selectable,
> >>>> do you agree that we can skip the above step 0 configuration you
> >>>> suggested.
> >>>>
> >>>> The changes proposed in the patch series essentially does the rest.
> >>>>
> >>>> 1) It validate the size against the arch specific limit during
> >>>> namespace creation. (part of step 1)
> >>>
> >>> This validation is a surprise failure to ndctl.
> >>>
> >>>> 2) It also disable initializing a region if it find the size not
> >>>> correctly aligned as per the platform requirement.
> >>>
> >>> There needs to be a way for the user to discover the correct alignment
> >>> that the kernel will accept.
> >>>
> >>>> 3) Direct map  mapping size is different from supported_alignment for a
> >>>> namespace. The supported alignment controls what possible PAGE SIZE user want the
> >>>> namespace to be mapped to user space.
> >>>
> >>> No, the namespace alignment is different than the page mapping size.
> >>> The alignment is only interpreted as a mapping size at the device-dax
> >>> level, otherwise at the raw namespace level it's just an arbitrary
> >>> alignment.
> >>>
> >>>> With the above do you think the current patch series is good?
> >>>
> >>> I don't think we've quite converged on a solution.
> >>
> >> How about we make it a property of seed device. ie,
> >> we add `supported_size_align` RO attribute to the seed device. ndctl can
> >> use this to validate the size value. So this now becomes step0
> >>
> >> sys/bus/nd/devices/region0> cat btt0.0/supported_size_align
> >> 16777216
> >> /sys/bus/nd/devices/region0> cat pfn0.0/supported_size_align
> >> 16777216
> >> /sys/bus/nd/devices/region0> cat dax0.0/supported_size_align
> >> 16777216
> >
> > Why on those devices and not namespace0.0?
>
> sure.
>
> >
> >> We follow that up with validating the size value written to size
> >> attribute(step 1).
> >>
> >> While initializing the namespaces already present in a region we again
> >> validate the size and if not properly aligned we mark the region
> >> disabled.
> >
> > The region might have a mix of namespaces, some aligned and some not,
> > only the misaligned namespaces should fail to enable. The region
> > should otherwise enable successfully.
> >
>
> One misaligned namespace would mean, we get other namespace resource
> start addr wrongly aligned. If we allow regions to be enabled with
> namespace with wrong size, user would find further namespace creation in
> that regions failing due to wrongly aligned resource start. IMHO that is
> a confusing user experience.
>

Why would one wrongly aligned namespace prevent other namespaces from
being aligned? There's no requirement that consecutive namespaces are
allocated contiguously. Also consider a namespace that starts
misaligned, but ends aligned. That subsequent namespace can be enabled
without issue.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
