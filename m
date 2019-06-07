Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E518D3951F
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 21:00:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9BE9921290DE3;
	Fri,  7 Jun 2019 12:00:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7E6F32128A630
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 12:00:48 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C3E7A20868;
 Fri,  7 Jun 2019 19:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559934047;
 bh=SaF9wNj2glMXJrUlhGfPV51XspfvGCl4GV+n5wOltIk=;
 h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
 b=pOa773KinCbWZNwUdN0H2jdZol+fGp2XY6GywMUyTl3QZS5pW9hFAAcg/RQpuePFb
 6lPWUUf3AvmyqHdMay0eDupbNJ7WbuBfNXwJ4jnDfqEl3Pw+6YKFdZVlrZIY2LFVvc
 bfbI2V1LcTAYX/HU3jn8XFwP21qj/1NllQ+0AO60=
MIME-Version: 1.0
In-Reply-To: <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com>
 <20190517182254.548EA20815@mail.kernel.org>
 <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
To: Iurii Zaikin <yzaikin@google.com>
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
User-Agent: alot/0.8.1
Date: Fri, 07 Jun 2019 12:00:47 -0700
Message-Id: <20190607190047.C3E7A20868@mail.kernel.org>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 yamada.masahiro@socionext.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com,
 kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au,
 rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 jpoimboe@redhat.com, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Quoting Iurii Zaikin (2019-06-05 18:29:42)
> On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-05-14 15:17:10)
> > > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > > new file mode 100644
> > > index 0000000000000..fe0f2bae66085
> > > --- /dev/null
> > > +++ b/kernel/sysctl-test.c
> > > +
> > > +
> > > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > > +{
> > > +       struct ctl_table table = {
> > > +               .procname = "foo",
> > > +               .data           = &test_data.int_0001,
> > > +               .maxlen         = sizeof(int),
> > > +               .mode           = 0644,
> > > +               .proc_handler   = proc_dointvec,
> > > +               .extra1         = &i_zero,
> > > +               .extra2         = &i_one_hundred,
> > > +       };
> > > +       char input[] = "-9";
> > > +       size_t len = sizeof(input) - 1;
> > > +       loff_t pos = 0;
> > > +
> > > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
> >
> > Is the casting necessary? Or can the macro do a type coercion of the
> > second parameter based on the first type?
>  Data field is defined as void* so I believe casting is necessary to
> dereference it as a pointer to an array of ints. I don't think the
> macro should do any type coercion that == operator wouldn't do.
>  I did change the cast to make it more clear that it's a pointer to an
> array of ints being dereferenced.

Ok, I still wonder if we should make KUNIT_EXPECT_EQ check the types on
both sides and cause a build warning/error if the types aren't the same.
This would be similar to our min/max macros that complain about
mismatched types in the comparisons. Then if a test developer needs to
convert one type or the other they could do so with a
KUNIT_EXPECT_EQ_T() macro that lists the types to coerce both sides to
explicitly.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
