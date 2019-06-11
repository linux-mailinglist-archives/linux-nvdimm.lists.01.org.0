Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D723D4B8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Jun 2019 19:58:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7663B21295B30;
	Tue, 11 Jun 2019 10:58:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4F344212909EF
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 10:58:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bi6so5040773plb.12
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ezWWyHmFr3D52R1hMjM3lFqjTF5qDUt/Gz8+w6Ybeeg=;
 b=NXabX8VKhqlLINuoMQHbinmJIUbVH0BN+gV3EBZfeU2WCiSZGaL5z1BBk/58lNpSLk
 6OZS/QBr9Xcqp8FLP0aoFzarQalnNz5o/W4LmU3plkkiz8px1w/b14QGZtx/LpELMViT
 Cq0zGOdkG0bUXDxO/omwJpd2ykSJkUq6SnLNsOdyke4UAJxvvy6sJ2KCrvAjbWxYUAfv
 mNi2NE/pq7hdDfUErhLVHQrN935jeqQID0v5d+Q6AZHeXiOFfmRa4pwDvFIRPShgom9k
 +iiaBa56wRxxqOBXtYUg69RYV0vztcjvfpfAUcRMjGUqaocx9uX+ixG798K/4fglHZBe
 neug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ezWWyHmFr3D52R1hMjM3lFqjTF5qDUt/Gz8+w6Ybeeg=;
 b=F52KNcsVP58A+JiPIW9Z6dqpdFCPEuYMuzJxmrGYOlulwS4J0RpEKUNIUdUwTFeYH4
 vPmOycLQye5LbvYxfZ+5UilidEfPGOtsts3DQnJk/i0Slk12VKI1lLtmRDPSYI2oDvIY
 flStH3RgfDG02+595IP7PBBss8gX/HxwT9z4JVwo1wijDkU9O0HZ2ElEe6hZHjIQ4Vvd
 XjU6xz1Bk4ASr7HFyAh/dxwHERIUJ4oJt0PFdTcfkCjbV8+yjLweci29VXTl0CZxcfU1
 Gw+j7ggj//1izWJtK0XZA5k3P3Fm9fvhflDWvpjNx7GnGt69XFm0FHCnf+ZFw19K51aJ
 H4lw==
X-Gm-Message-State: APjAAAX/DmDUuy0erBYulhcJ8CCJbx2cBdHEjnKZdbEn/fgWPvadLn5e
 vKVAipvN0lsz+gQ1+DjbhtlVhw==
X-Google-Smtp-Source: APXvYqxLhXRMoy3niXLUf+3yjcR+oYOqDZdO4IrAaXbVjtaTgohrWX6P7B3Tnf00xa75XTTIUTknBA==
X-Received: by 2002:a17:902:3341:: with SMTP id
 a59mr47725400plc.186.1560275916197; 
 Tue, 11 Jun 2019 10:58:36 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
 by smtp.gmail.com with ESMTPSA id s64sm13222982pfb.160.2019.06.11.10.58.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 10:58:35 -0700 (PDT)
Date: Tue, 11 Jun 2019 10:58:30 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Message-ID: <20190611175830.GA236872@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com>
 <20190517182254.548EA20815@mail.kernel.org>
 <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
 <20190607190047.C3E7A20868@mail.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190607190047.C3E7A20868@mail.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 amir73il@gmail.com, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, Iurii Zaikin <yzaikin@google.com>,
 jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 07, 2019 at 12:00:47PM -0700, Stephen Boyd wrote:
> Quoting Iurii Zaikin (2019-06-05 18:29:42)
> > On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-05-14 15:17:10)
> > > > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > > > new file mode 100644
> > > > index 0000000000000..fe0f2bae66085
> > > > --- /dev/null
> > > > +++ b/kernel/sysctl-test.c
> > > > +
> > > > +
> > > > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > > > +{
> > > > +       struct ctl_table table = {
> > > > +               .procname = "foo",
> > > > +               .data           = &test_data.int_0001,
> > > > +               .maxlen         = sizeof(int),
> > > > +               .mode           = 0644,
> > > > +               .proc_handler   = proc_dointvec,
> > > > +               .extra1         = &i_zero,
> > > > +               .extra2         = &i_one_hundred,
> > > > +       };
> > > > +       char input[] = "-9";
> > > > +       size_t len = sizeof(input) - 1;
> > > > +       loff_t pos = 0;
> > > > +
> > > > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > > > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
> > >
> > > Is the casting necessary? Or can the macro do a type coercion of the
> > > second parameter based on the first type?
> >  Data field is defined as void* so I believe casting is necessary to
> > dereference it as a pointer to an array of ints. I don't think the
> > macro should do any type coercion that == operator wouldn't do.
> >  I did change the cast to make it more clear that it's a pointer to an
> > array of ints being dereferenced.
> 
> Ok, I still wonder if we should make KUNIT_EXPECT_EQ check the types on
> both sides and cause a build warning/error if the types aren't the same.
> This would be similar to our min/max macros that complain about
> mismatched types in the comparisons. Then if a test developer needs to
> convert one type or the other they could do so with a
> KUNIT_EXPECT_EQ_T() macro that lists the types to coerce both sides to
> explicitly.

Do you think it would be better to do a phony compare similar to how
min/max used to work prior to 4.17, or to use the new __typecheck(...)
macro? This might seem like a dumb question (and maybe it is), but Iurii
and I thought the former created an error message that was a bit easier
to understand, whereas __typecheck is obviously superior in terms of
code reuse.

This is what we are thinking right now; if you don't have any complaints
I will squash it into the relevant commits on the next revision:
---
From: Iurii Zaikin <yzaikin@google.com>

Adds a warning message when comparing values of different types similar
to what min() / max() macros do.

Signed-off-by: Iurii Zaikin <yzaikin@google.com>
---
 include/kunit/test.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 511c9e85401a6..791e22fba5620 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -335,6 +335,13 @@ void __printf(3, 4) kunit_printk(const char *level,
 #define kunit_err(test, fmt, ...) \
 		kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
 
+/*
+ * 'Unnecessary' cast serves to generate a compile-time warning in case
+ * of comparing incompatible types. Inspired by include/linux/kernel.h
+ */
+#define __kunit_typecheck(lhs, rhs) \
+	((void) (&(lhs) == &(rhs)))
+
 static inline struct kunit_stream *kunit_expect_start(struct kunit *test,
 						      const char *file,
 						      const char *line)
@@ -514,6 +521,7 @@ static inline void kunit_expect_ptr_binary(struct kunit *test,
 #define KUNIT_EXPECT_BINARY(test, left, condition, right) do {		       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_expect_binary(test,					       \
 			    (long long) __left, #left,			       \
 			    (long long) __right, #right,		       \
@@ -524,6 +532,7 @@ static inline void kunit_expect_ptr_binary(struct kunit *test,
 #define KUNIT_EXPECT_BINARY_MSG(test, left, condition, right, fmt, ...) do {   \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_expect_binary_msg(test,					       \
 				(long long) __left, #left,		       \
 				(long long) __right, #right,		       \
@@ -538,6 +547,7 @@ static inline void kunit_expect_ptr_binary(struct kunit *test,
 #define KUNIT_EXPECT_PTR_BINARY(test, left, condition, right) do {	       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_expect_ptr_binary(test,					       \
 			    (void *) __left, #left,			       \
 			    (void *) __right, #right,			       \
@@ -553,6 +563,7 @@ static inline void kunit_expect_ptr_binary(struct kunit *test,
 				    ...) do {				       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_expect_ptr_binary_msg(test,				       \
 				    (void *) __left, #left,		       \
 				    (void *) __right, #right,		       \
@@ -1013,6 +1024,7 @@ static inline void kunit_assert_ptr_binary(struct kunit *test,
 #define KUNIT_ASSERT_BINARY(test, left, condition, right) do {		       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_assert_binary(test,					       \
 			    (long long) __left, #left,			       \
 			    (long long) __right, #right,		       \
@@ -1023,6 +1035,7 @@ static inline void kunit_assert_ptr_binary(struct kunit *test,
 #define KUNIT_ASSERT_BINARY_MSG(test, left, condition, right, fmt, ...) do {   \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_assert_binary_msg(test,					       \
 				(long long) __left, #left,		       \
 				(long long) __right, #right,		       \
@@ -1037,6 +1050,7 @@ static inline void kunit_assert_ptr_binary(struct kunit *test,
 #define KUNIT_ASSERT_PTR_BINARY(test, left, condition, right) do {	       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_assert_ptr_binary(test,					       \
 				(void *) __left, #left,			       \
 				(void *) __right, #right,		       \
@@ -1051,6 +1065,7 @@ static inline void kunit_assert_ptr_binary(struct kunit *test,
 				    fmt, ...) do {			       \
 	typeof(left) __left = (left);					       \
 	typeof(right) __right = (right);				       \
+	__kunit_typecheck(__left, __right);				       \
 	kunit_assert_ptr_binary_msg(test,				       \
 				    (void *) __left, #left,		       \
 				    (void *) __right, #right,		       \
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
